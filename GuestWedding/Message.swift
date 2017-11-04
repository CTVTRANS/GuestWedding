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

    var isMyOwner: Bool!
    var messageBoby: String?
    var time: String?
    
    init(json: JSON) {
        let objectSend = json["FROM_USER_GROUP"].string
        if objectSend == "W0" {
            isMyOwner = true
        } else {
            isMyOwner = false
        }
        messageBoby = json["MESSAGE_CONTENT"].string
        time = json["MESSAGE_TIME"].string
    }
}
