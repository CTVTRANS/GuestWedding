//
//  GetMessageTask.swift
//  GuestWedding
//
//  Created by Kien on 11/3/17.
//  Copyright © 2017 Kien. All rights reserved.
//

import UIKit
import SwiftyJSON

class GetMessageTask: LKNetwork {
    
    var userID: String!
    var page: Int!
    var limit = 20
    
    init( userID: String, page: Int) {
        self.userID = userID
        self.page = page
    }

    override func path() -> String {
        return getMessageURL
    }
    
    override func method() -> HTTPMethod {
        return .GET
    }
    
    override func parameters() -> [String: Any] {
        return ["id": Guest.shared.account,
                "user_id": userID,
                "pno": page,
                "pnum": limit]
    }
    
    override func dataWithResponse(_ response: Any) -> Any {
        var listMessage: [Message] = []
        if let arrayMessage = response as? JSON {
            if arrayMessage.type == .array {
                for messageJSON in arrayMessage.array! {
                    let message = Message(json: messageJSON)
                    listMessage.append(message)
                }
            }
        }
        return listMessage
    }
}
