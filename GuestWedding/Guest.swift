//
//  Guest.swift
//  GuestWedding
//
//  Created by Kien on 11/1/17.
//  Copyright © 2017 Kien. All rights reserved.
//

import UIKit
import SwiftyJSON

struct Guest {

    var account: String?
    var usename: String?
    var mobile: String?
    var email: String?
    var token: String?
    
    init(_ json: JSON) {
        account = json["ACCOUNT"].string
        usename = json["USERNAME"].string
        mobile = json["MOBILE"].string
        email = json["EMAIL"].string
        token = json["token"].string
    }
}
