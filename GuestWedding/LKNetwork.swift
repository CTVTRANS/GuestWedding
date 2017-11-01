//
//  LKNetwork.swift
//  GuestWedding
//
//  Created by Kien on 11/1/17.
//  Copyright © 2017 Kien. All rights reserved.
//

import UIKit
import SystemConfiguration

enum HTTPMethod: String {
    case POST
    case GET
}

typealias BlockSucess = (Any) -> Void
typealias BlockFailure = (String) -> Void
typealias BlockProgess = (Float) -> Void

class LKNetwork: NSObject {
    
    var request : URLRequest?
    var session = URLSession.shared
    let timeOut = 30.0
    
    static func shared() ->  LKNetwork {
        return LKNetwork()
    }
    private override init() {}
    
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
    
    func getParams(params:[String: Any]) -> String {
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
    
    func requestServer(sucess: @escaping BlockSucess, failure: @escaping BlockFailure) {
        if !isInternetAvailable() {
            
            return
        }
        let params = getParams(params: parameters())
        request?.httpMethod = method().rawValue
        if method() == .POST {
            request = URLRequest(url: URL(string:path())!)
            request?.httpBody = params.data(using: .utf8)
        } else {
            request = URLRequest(url: URL(string:path() + params)!)
        }
        request?.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        setUpTimeOut()
        
        let task = session.dataTask(with: request!) { (data, urlResponse, error) in
            DispatchQueue.main.async {
                if error != nil {
                    failure((error?.localizedDescription)!)
                    return
                }
//                let json = try? JSONSerialization.jsonObject(with: data!, options: [])
                let json =  self.dataWithResponse(data!)
                sucess(json)
            }
        }
        task.resume()
    }
    

    // MARK: HTTP Method
    
    func method() -> HTTPMethod {
        return .GET
    }
    
    func parameters() -> [String: Any] {
        return ["": ""]
    }
    
    func parameterUpFile() -> [String: Any] {
        return ["": ""]
    }
    
    func path() -> String {
        return ""
    }
    
    func dataUpLoad() -> Data? {
        return nil
    }
    
    func dataWithResponse(_ response: Any) -> Any {
        return response
    }
    
}
