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
    
    static let kIdMember = "idMember"
    static let kNameMember = "nameMember"
    static let kManName = "manName"
    static let KNameWoman = "nameWoman"
    static let kDateMan = "dateMan"
    static let kDateWoman = "dateWoman"
    static let kNumberGuestMan = "numberGuestMan"
    static let kNumberGuestWoman = "numberGuestWoman"
    static let kCounterManDate = "counterManDate"
    static let kCounterWomanDate = "counterWomanDate"
    static let kLinkweb = "linkweb"
    static let kImageOfSeat = "imageOfSeat"
    static let kNameCompany = "nameCompany"

    var idMember = ""
    var nameMember = ""
    var manName = ""
    var nameWoman = ""
    var dateMan = ""
    var dateWoman = ""
    var numberGuestMan = 0
    var numberGuestWoman = 0
    var counterManDate = ""
    var counterWomanDate = ""
    var linkweb: String = ""
    var imageOfSeat = ""
    var nameCompany = ""
    
    static func decodeJson(_ json: JSON) -> Member {
        return Member(idMember: json["ACCOUNT"].stringValue,
                      nameMember: json["NM"].stringValue,
                      manName: json["ManNM"].stringValue,
                      nameWoman: json["WomanNM"].stringValue,
                      dateMan: json["ENGDTD"].stringValue,
                      dateWoman: json["COUPLEENGDTD"].stringValue,
                      numberGuestMan: json["VIPLETTERCOUNT1"].intValue,
                      numberGuestWoman: json["VIPLETTERCOUNT2"].intValue,
                      counterManDate: json["ENGDTDCounter"].stringValue,
                      counterWomanDate: json["COUPLEENGDTDCounter"].stringValue,
                      linkweb: json["MEMBER_URL"].stringValue,
                      imageOfSeat: json["MEMBER_DOC_TABLE_URL"].stringValue,
                      nameCompany: json["COMPANYNM"].stringValue
        )
    }
    static var shared = Member()
}

extension HeperMember: Encodable {
    var value: Member? {
        return member
    }
}

extension Member: Encoded {
    var encoder: HeperMember {
        return HeperMember(member: self)
    }
}

class HeperMember: NSObject, NSCoding {
    func encode(with aCoder: NSCoder) {
        aCoder.encode(member?.idMember, forKey: Member.kIdMember)
        aCoder.encode(member?.nameMember, forKey: Member.kNameMember)
        aCoder.encode(member?.manName, forKey: Member.kManName)
        aCoder.encode(member?.nameWoman, forKey: Member.KNameWoman)
        aCoder.encode(member?.dateMan, forKey: Member.kDateMan)
        aCoder.encode(member?.dateWoman, forKey: Member.kDateWoman)
        aCoder.encode(member?.numberGuestMan, forKey: Member.kNumberGuestMan)
        aCoder.encode(member?.numberGuestWoman, forKey: Member.kNumberGuestWoman)
        aCoder.encode(member?.counterManDate, forKey: Member.kCounterManDate)
        aCoder.encode(member?.counterWomanDate, forKey: Member.kCounterWomanDate)
        aCoder.encode(member?.linkweb, forKey: Member.kLinkweb)
        aCoder.encode(member?.imageOfSeat, forKey: Member.kImageOfSeat)
        aCoder.encode(member?.nameCompany, forKey: Member.kNameCompany)
    }
    
    var member: Member?
    
    init(member: Member) {
        self.member = member
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        guard let idMember = aDecoder.decodeObject(forKey: Member.kIdMember) as? String,
        let nameMember = aDecoder.decodeObject(forKey: Member.kNameMember) as? String,
        let nameMan = aDecoder.decodeObject(forKey: Member.kManName) as? String,
        let nameWoman = aDecoder.decodeObject(forKey: Member.KNameWoman) as? String,
        let dateMan = aDecoder.decodeObject(forKey: Member.kDateMan) as? String,
        let dateWoman = aDecoder.decodeObject(forKey: Member.kDateWoman) as? String,
        let numberMan = aDecoder.decodeObject(forKey: Member.kNumberGuestMan) as? Int,
        let numberWoman = aDecoder.decodeObject(forKey: Member.kNumberGuestWoman) as? Int,
        let counterMan = aDecoder.decodeObject(forKey: Member.kCounterManDate) as? String,
        let counterWoman = aDecoder.decodeObject(forKey: Member.kCounterWomanDate) as? String,
        let linkWed = aDecoder.decodeObject(forKey: Member.kLinkweb) as? String,
        let imageOfSeat =  aDecoder.decodeObject(forKey: Member.kImageOfSeat) as? String,
        let companyName =  aDecoder.decodeObject(forKey: Member.kNameCompany) as? String  else {
                member = nil
                super.init()
                return nil
        }
        
        member = Member(idMember: idMember,
                        nameMember: nameMember,
                        manName: nameMan,
                        nameWoman: nameWoman,
                        dateMan: dateMan,
                        dateWoman: dateWoman,
                        numberGuestMan: numberMan,
                        numberGuestWoman: numberWoman,
                        counterManDate: counterMan,
                        counterWomanDate: counterWoman,
                        linkweb: linkWed,
                        imageOfSeat: imageOfSeat,
                        nameCompany: companyName)
        super.init()
    }
}
