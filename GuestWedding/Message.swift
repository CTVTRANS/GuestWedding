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

    var messageOwner: String?
    var messageBoby: String?
    var time: String?
    
    init(json: JSON) {
        messageOwner = json[""].string
        messageBoby = json[""].string
        time = json[""].string
    }
}
