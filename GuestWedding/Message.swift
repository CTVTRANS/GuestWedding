//
//  Message.swift
//  GuestWedding
//
//  Created by Kien on 11/2/17.
//  Copyright © 2017 Kien. All rights reserved.
//

import UIKit
import SwiftyJSON

struct Message {

    var isMyOwner = false
    var messageBoby = ""
    var time = ""
    var isRead = false
    
    init(json: JSON) {
        if let objectSend = json["FROM_USER_GROUP"].string {
            if objectSend == "W0" {
                isMyOwner = true
            } else {
                isMyOwner = false
            }
        }
        isRead = json["IS_PUSH"].intValue == 1 ? true : false
        messageBoby = json["MESSAGE_CONTENT"].stringValue
        time = json["MESSAGE_TIME"].stringValue
    }
}
