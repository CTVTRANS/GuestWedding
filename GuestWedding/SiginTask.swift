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
    
    var idGuest: String!
    var nameMemer: String!
    
    init(idGuest: String, nameMember: String) {
        self.idGuest = idGuest
        self.nameMemer = nameMember
    }
    
    override func path() -> String {
        return siginURL + "id=\(idGuest!)"
    }
    
    override func method() -> HTTPMethod {
        return .POST
    }
    
    override func parameters() -> [String: Any] {
        return ["MemberList": nameMemer]
    }
    
    override func dataWithResponse(_ response: Any) -> Any {
        guard let json = response as? JSON else {
            return ""
        }
        let memberAccount = json["MEMBER_ACCOUNT_LIST"].stringValue
        return memberAccount
    }
}
