//
//  UpdateToken.swift
//  GuestWedding
//
//  Created by le kien on 12/22/17.
//  Copyright © 2017 Kien. All rights reserved.
//

import Foundation
import SwiftyJSON

class UpdateToken: LKNetwork {

    var token: String?
    init(token: String?) {
        self.token = token
    }
    
    override func path() -> String {
        return "/api/UpdateData.aspx?id=" + Guest.shared.account
    }
    
    override func parameters() -> [String: Any] {
        return["todo": "UpdateGuestInfo",
               "token": token]
    }
    
    override func dataWithResponse(_ response: Any) -> Any {
        if let data = response as? JSON {
            let status = data["ErrMsg"].stringValue
            return status
        }
        return response
    }
}
