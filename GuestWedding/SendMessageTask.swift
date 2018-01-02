//
//  SendMessageTask.swift
//  GuestWedding
//
//  Created by le kien on 11/13/17.
//  Copyright © 2017 Kien. All rights reserved.
//

import UIKit

class SendMessageTask: LKNetwork {
    
    var message: String!
    
    init(msg: String) {
        message = msg
    }

    override func path() -> String {
        return sendMessageURL + "id=" + Guest.shared.account
    }
    
    override func method() -> HTTPMethod {
        return .POST
    }
    
    override func parameters() -> [String: Any] {
        return ["msg": message,
                "todo": "GuestAddMessageToMember",
                "MemberList": Member.shared.idMember]
    }
    
    override func dataWithResponse(_ response: Any) -> Any {
        return response
    }
}
