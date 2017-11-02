//
//  Member.swift
//  GuestWedding
//
//  Created by Kien on 11/1/17.
//  Copyright © 2017 Kien. All rights reserved.
//

import UIKit
import SwiftyJSON

class Member {

    var manName: String?
    var nameWoman: String?
    var dateMan: String?
    var dateWoman: String?
    var numberGuestMan: String?
    var numberGuestWoman: String?
    var linkweb: String?
    
    init(json: JSON) {
        manName = json[""].string
        nameWoman = json[""].string
        dateMan = json[""].string
        dateWoman = json[""].string
        numberGuestMan = json[""].string
        numberGuestWoman = json[""].string
        linkweb = "http://www.freewed.com.tw/app/LOVE.aspx?ACCT=ann730204"
    }
    
    static let shared = Member()
    init() {}
}
