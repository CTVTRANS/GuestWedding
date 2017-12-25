//
//  UpdateGuestInfo.swift
//  GuestWedding
//
//  Created by le kien on 11/29/17.
//  Copyright © 2017 Kien. All rights reserved.
//

import UIKit
import SwiftyJSON

class UpdateGuestInfo: LKNetwork {
    
    var data: NSData?
    var userName: String?
    var mobile: String?
    var email: String?
    
    init(data: NSData?, username: String?, mobile: String?, email: String?) {
        self.data = data
        self.userName = username
        self.mobile = mobile
        self.email = email
    }
    
    override func path() -> String {
        return "/api/UpdateData.aspx?id=0912345678"
    }
    
    override func parameters() -> [String: Any] {
        return["todo": "UpdateGuestInfo",
               "USERNAME": userName,
               "MOBILE": mobile,
               "EMAIL": email]
    }
    
    override func name() -> String {
        return "LOGO"
    }
    
    override func nameFile() -> String {
        return "avatar.png"
    }
    
    override func dataUpLoad() -> NSData? {
        return data
    }
    
    override func dataWithResponse(_ response: Any) -> Any {
        if let data = response as? JSON {
            let status = data["ErrMsg"].stringValue
                return status
        }
        return response
    }
}
