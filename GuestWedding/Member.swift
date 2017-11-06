//
//  Member.swift
//  GuestWedding
//
//  Created by Kien on 11/1/17.
//  Copyright © 2017 Kien. All rights reserved.
//

import UIKit
import SwiftyJSON

struct Member {

    var idMember: String?
    var nameMember: String?
    var manName: String?
    var nameWoman: String?
    var dateMan: String?
    var dateWoman: String?
    var numberGuestMan: Int?
    var numberGuestWoman: Int?
    var counterManDate: String?
    var counterWomanDate: String?
    var linkweb: String = ""
    
    init(json: JSON) {
        idMember = json["ACCOUNT"].string
        nameMember = json["NM"].string
        manName = json["ManNM"].string
        nameWoman = json["WomanNM"].string
        dateMan = json["ENGDTD"].string
        dateWoman = json["COUPLEENGDTD"].string
        numberGuestMan = json["VIPLETTERCOUNT1"].int
        numberGuestWoman = json["VIPLETTERCOUNT2"].int
        counterManDate = json["ENGDTDCounter"].string
        counterWomanDate = json["COUPLEENGDTDCounter"].string
        linkweb = json["MEMBER_URL"].string!
    }
    init() {}
}
