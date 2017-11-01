//
//  SiginTask.swift
//  GuestWedding
//
//  Created by Kien on 11/1/17.
//  Copyright © 2017 Kien. All rights reserved.
//

import UIKit
import SwiftyJSON

class SiginTask: LKNetwork {
    
    var idGuest: Int!
    
    init(idGuest: Int) {
        self.idGuest = idGuest
    }
    
    override func path() -> String {
        return siginURL
    }
    
    override func method() -> HTTPMethod {
        return .GET
    }
    
    override func parameters() -> [String: Any] {
        return ["id": idGuest]
    }
    
    override func dataWithResponse(_ response: Any) -> Any {
        if let json = response as? JSON {
             let guest = Guest(json)
            return guest
        }
        return ""
    }
}
