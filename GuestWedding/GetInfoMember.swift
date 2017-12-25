//
//  GetInfoMember.swift
//  GuestWedding
//
//  Created by le kien on 12/20/17.
//  Copyright © 2017 Kien. All rights reserved.
//

import Foundation
import  SwiftyJSON

class GetInfo: LKNetwork {
    
    var idGuest: String!
    var nameMember: String!
    
    init(idGuest: String, nameMember: String) {
        self.idGuest = idGuest
        self.nameMember = nameMember
    }
    
    override func path() -> String {
        return getInfo
    }
    
    override func method() -> HTTPMethod {
        return .GET
    }
    
    override func parameters() -> [String: Any] {
        return ["id": idGuest]
    }
    
    override func dataWithResponse(_ response: Any) -> Any {
        guard let json = response as? JSON else {
            return ""
        }
        let guest = Guest.decodeJson(json)
        let arrayMember = json["MEMBER_LIST"].array
        guard arrayMember?.first != nil else {
            return ""
        }
        for jsomMember in arrayMember! {
            let member = Member.decodeJson(jsomMember)
            if member.idMember == nameMember {
                return (guest, member)
            }
        }
        return ""
    }
}
