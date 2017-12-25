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
    static let kAccount = "account"
    static let kUsename = "usename"
    static let kMobile = "mobile"
    static let kEmail = "email"
    static let kAvatar = "avatar"

    var account = ""
    var usename = ""
    var mobile = ""
    var email = ""
    var avatar = ""
    
    static func decodeJson(_ json: JSON) -> Guest {
        return Guest(account: json["ACCOUNT"].stringValue,
                     usename: json["USERNAME"].stringValue,
                     mobile: json["MOBILE"].stringValue,
                     email: json["EMAIL"].stringValue,
                     avatar: json["LOGO"].stringValue)
    }
    static var shared = Guest()
}

extension HeperGuest: Encodable {
    var value: Guest? {
        return guest
    }
}

extension Guest: Encoded {
    var encoder: HeperGuest {
        return HeperGuest(guest: self)
    }
}

class HeperGuest: NSObject, NSCoding {
    func encode(with aCoder: NSCoder) {
        aCoder.encode(guest?.account, forKey: Guest.kAccount)
        aCoder.encode(guest?.usename, forKey: Guest.kUsename)
        aCoder.encode(guest?.mobile, forKey: Guest.kMobile)
        aCoder.encode(guest?.email, forKey: Guest.kEmail)
        aCoder.encode(guest?.avatar, forKey: Guest.kAvatar)
    }
    
    var guest: Guest?
    
    init(guest: Guest) {
        self.guest = guest
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        guard let account = aDecoder.decodeObject(forKey: Guest.kAccount) as? String,
            let usename = aDecoder.decodeObject(forKey: Guest.kUsename) as? String,
            let mobile = aDecoder.decodeObject(forKey: Guest.kMobile) as? String,
            let email = aDecoder.decodeObject(forKey: Guest.kEmail) as? String,
            let avatar = aDecoder.decodeObject(forKey: Guest.kAvatar) as? String else {
                guest = nil
                super.init()
                return nil
        }
        
        guest = Guest(account: account,
                       usename: usename,
                       mobile: mobile,
                       email: email,
                       avatar: avatar)
        super.init()
    }
}
