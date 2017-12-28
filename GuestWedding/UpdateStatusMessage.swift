
//
//  UpdateStatusMessage.swift
//  GuestWedding
//
//  Created by le kien on 12/28/17.
//  Copyright © 2017 Kien. All rights reserved.
//

import Foundation
import SwiftyJSON

class UpdateStatusMessage: LKNetwork {
    
    var idmember = ""
    
    init(idMember: String) {
        self.idmember = idMember
    }
    
    override func path() -> String {
        return updateMessageStatus + "id=\(Guest.shared.account)&user_id=\(idmember)"
    }
    
    override func method() -> HTTPMethod {
        return .GET
    }
    
    override func dataWithResponse(_ response: Any) -> Any {
        return response
    }
}
