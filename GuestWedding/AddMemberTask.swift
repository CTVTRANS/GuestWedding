//
//  AddMemberTask.swift
//  GuestWedding
//
//  Created by Kien on 11/1/17.
//  Copyright © 2017 Kien. All rights reserved.
//

import UIKit
import SwiftyJSON

class AddMemberTask: LKNetwork {
    
    var todo: String!
    var member: String!
    
    init(actionTag: String, member: String) {
        todo = actionTag
        self.member = member
    }
    
    override func path() -> String {
        return followMemberURL + "id=" + Guest.shared.idGuest!
    }
    
    override func parameters() -> [String: Any] {
        return ["todo": todo, "MemberList": member]
    }
    
    override func method() -> HTTPMethod {
        return .POST
    }
    
    override func dataWithResponse(_ response: Any) -> Any {
        if let json = response as? JSON {
            if let msg = json["ErrMsg"].string {
                return msg
            }
        }
        return ""
    }
}
