//
//  GetNumberMessage.swift
//  GuestWedding
//
//  Created by le kien on 1/3/18.
//  Copyright © 2018 Kien. All rights reserved.
//

import Foundation
import SwiftyJSON

class GetNumberMessage: LKNetwork {
    
    override func path() -> String {
        return getNumberNotice
    }
    
    override func method() -> HTTPMethod {
        return .GET
    }
    
    override func parameters() -> [String: Any] {
        return ["id": Guest.shared.account]
    }
    
    override func dataWithResponse(_ response: Any) -> Any {
        var numberMessage = 0
        var numberQuestion = 0
        var numberSeat = 0
        if let json = response as? JSON {
            numberMessage = json["count1"].intValue
            numberQuestion = json["count4"].intValue
            numberSeat = json["count2"].intValue
        }
        return (numberMessage, numberQuestion, numberSeat)
    }
}
