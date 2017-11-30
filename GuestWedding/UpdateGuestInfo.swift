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
    
    var data: Data
    var fileName: String
    
    init(data: Data, flieName: String) {
        self.data = data
        self.fileName = flieName
    }
    
    override func path() -> String {
        return "/api/UpdateData.aspx?id=0912345678"
    }
    
    override func parameters() -> [String: Any] {
        return["todo": "UpdateGuestInfo"]
    }
    
    override func name() -> String {
        return "LOGO"
    }
    
    override func nameFile() -> String {
        return "avatar.png"
    }
    
    override func dataUpLoad() -> Data? {
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
