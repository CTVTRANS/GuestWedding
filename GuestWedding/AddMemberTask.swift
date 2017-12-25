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
    
    var memberAccount: String!
    
    init(member: String) {
        self.memberAccount = member
    }
    
    override func path() -> String {
        return followMemberURL + "id=" + Guest.shared.account
    }
    
    override func parameters() -> [String: Any] {
        return ["todo": "GuestAddMemberTrace", "MemberList": memberAccount]
    }
    
    override func method() -> HTTPMethod {
        return .POST
    }
    
    override func dataWithResponse(_ response: Any) -> Any {
        if let jsonResponse = response as? JSON {
            guard let msg = jsonResponse["ErrCode"].string  else {
                return ""
            }
            guard let errorCode = Int(msg) else {
                return ""
            }
            guard errorCode >= 0  else {
                return ""
            }
            if let jsons = jsonResponse["MEMBER_LIST"].array {
                for json in jsons {
                    let member = Member.decodeJson(json)
                    if member.idMember == memberAccount {
                        return member
                    }
                }
            }
        }
        return ""
    }
}
