//
//  SiginTask.swift
//  GuestWedding
//
//  Created by Kien on 11/1/17.
//  Copyright © 2017 Kien. All rights reserved.
//

import UIKit
import SwiftyJSON

class SiginTask: LKNetwork {
    
    var idGuest: String!
    
    init(idGuest: String) {
        self.idGuest = idGuest
    }
    
    override func path() -> String {
        return siginURL
    }
    
    override func method() -> HTTPMethod {
        return .GET
    }
    
    override func parameters() -> [String: Any] {
        return ["id": idGuest]
    }
    
    override func dataWithResponse(_ response: Any) -> Any {
        var guest: Guest?
        var listMember: [Member] = []
        if let json = response as? JSON {
            guest = Guest(json)
            let arrayMember = json["MEMBER_LIST"].array
            if arrayMember?.first != nil {
                for jsomMember in arrayMember! {
                    let member = Member(json: jsomMember)
                    listMember.append(member)
                }
            }
            return (guest, listMember)
        }
        return ""
    }
}
