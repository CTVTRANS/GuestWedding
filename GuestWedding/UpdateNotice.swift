//
//  UpdateNotice.swift
//  GuestWedding
//
//  Created by le kien on 1/3/18.
//  Copyright © 2018 Kien. All rights reserved.
//

import Foundation

class UpdateNotice: LKNetwork {
    
    var type = 1
    
    init(type: Int) {
        self.type = type
    }
    
    override func path() -> String {
        return updateNumberNotice
    }
    
    override func parameters() -> [String : Any] {
        return ["id": Guest.shared.account, "t": type]
    }
    
    override func dataWithResponse(_ response: Any) -> Any {
        return response
    }
}

