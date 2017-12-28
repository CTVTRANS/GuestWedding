//
//  LKNetwork.swift
//  GuestWedding
//
//  Created by Kien on 11/1/17.
//  Copyright © 2017 Kien. All rights reserved.
//

import UIKit
import SystemConfiguration
import SwiftyJSON

enum HTTPMethod: String {
    case POST
    case GET
}

typealias BlockSucess = (Any) -> Void
typealias BlockFailure = (String) -> Void
typealias BlockProgess = (Float) -> Void

class LKNetwork: NSObject {
    
    var request: URLRequest?
//    var mutableRequest: MutableURLRequest?
    var session = URLSession.shared
    let timeOut = 30.0
    
    static func shared() -> LKNetwork {
        return LKNetwork()
    }
    
    // MARK: Check Internet Acess
    
    func isInternetAvailable() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return isReachable && !needsConnection
    }
    
    func getParams(params: [String: Any]) -> String {
        var data = [String]()
        for(key, value) in params {
            data.append(key + "=\(value)")
        }
        return data.map { String($0) }.joined(separator: "&")
    }
    
    func setUpTimeOut() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = timeOut
        configuration.timeoutIntervalForResource = timeOut
        session = URLSession(configuration: configuration)
    }
    
    // MARK: Call Request
    func requestServer(sucess: @escaping BlockSucess, failure: @escaping BlockFailure) {
        if !isInternetAvailable() {
            failure("No Internet Access")
            return
        }
        let params = getParams(params: parameters())
        let url = baseURL + path()
        if method() == .POST {
            request = URLRequest(url: URL(string: url)!)
            request?.httpBody = params.data(using: .utf8)
        } else {
            request = URLRequest(url: URL(string: url + params)!)
        }
        request?.httpMethod = method().rawValue
        request?.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request?.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Accept")
        setUpTimeOut()
        
        let task = session.dataTask(with: request!) { (data, _, error) in
            DispatchQueue.main.async {
                if error != nil {
                    failure((error?.localizedDescription)!)
                    return
                }
                let json = JSON(data: data!)
                let error = json["ErrCode"].string
                let error1 = json["RtnCode"].string
                if error == "-1" || error1 == "-1" {
                    failure(json["ErrMsg"].string!)
                    return
                }
                
                sucess(self.dataWithResponse(json))
            }
        }
        task.resume()
    }
    
    func upLoadData(sucess: @escaping BlockSucess, failure: @escaping BlockFailure) {
        if !isInternetAvailable() {
            failure("No Internet Access")
            return
        }
        let imageData = dataUpLoad()
        let url = baseURL + path()
        let fileName = nameFile()
        let params = parameters()
        let patkKeyFile = name()
        
        request = URLRequest(url: URL(string: url)!)
        request?.httpMethod = "POST"
        let boundary = generateBoundaryString()
        request?.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request?.httpBody = createBodyWithParameters(parameters: params,
                                                     filePathKey: patkKeyFile,
                                                     imageDataKey: imageData,
                                                     filename: fileName,
                                                     boundary: boundary) as Data
        setUpTimeOut()
        let task = session.dataTask(with: request!) { (data, _, error) in
            DispatchQueue.main.async {
                if error != nil {
                    failure((error?.localizedDescription)!)
                    return
                }
                let json = JSON(data: data!)
                debugPrint(json)
                let error = json["ErrCode"].string
                let error1 = json["RtnCode"].string
                if error == "-1" || error1 == "-1" {
                    failure(json["ErrMsg"].string!)
                }
                sucess(self.dataWithResponse(json))
            }
        }
        task.resume()
    }
    
    func createBodyWithParameters(parameters: [String: Any]?,
                                  filePathKey: String?,
                                  imageDataKey: NSData?,
                                  filename: String,
                                  boundary: String) -> NSData {
        let body = NSMutableData()
        if parameters != nil {
            for (key, value) in parameters! {
                body.appendString("--\(boundary)\r\n")
                body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString("\(value)\r\n")
            }
        }
        let mimetype = "png/jpg"
        body.appendString("--\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
        body.appendString("Content-Type: \(mimetype)\r\n\r\n")
        if let myData = imageDataKey as Data? {
             body.append(myData)
        }
        body.appendString("\r\n")
        body.appendString("--\(boundary)--\r\n")
        return body
    }
    
    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    // MARK: HTTP Method
    
    func method() -> HTTPMethod {
        return .GET
    }
    
    func parameters() -> [String: Any] {
        return ["": ""]
    }
    
    func name() -> String {
        return ""
    }
    
    func nameFile() -> String {
        return ""
    }
    
    func path() -> String {
        return ""
    }
    
    func dataUpLoad() -> NSData? {
        return nil
    }
    
    func dataWithResponse(_ response: Any) -> Any {
        return response
    }
}

extension NSMutableData {
    func appendString(_ string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
    }
}
