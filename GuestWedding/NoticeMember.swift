//
//  NoticeMember.swift
//  GuestWedding
//
//  Created by le kien on 11/6/17.
//  Copyright © 2017 Kien. All rights reserved.
//

import UIKit

class NoticeMember: NSObject, NSCoding {
    var numberMessage: Int!
    var numberSeat: Int!
    var numberQuestion: Int!
    
    init(numberMessage: Int, numberSeat: Int, numberQuestion: Int) {
        self.numberMessage = numberMessage
        self.numberSeat = numberSeat
        self.numberQuestion = numberQuestion
    }
    
    required init?(coder aDecoder: NSCoder) {
        numberMessage = aDecoder.decodeObject(forKey: "numberMessage") as? Int
        numberSeat = aDecoder.decodeObject(forKey: "numberSeat") as? Int
        numberQuestion = aDecoder.decodeObject(forKey: "numberQuestion") as? Int
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(numberMessage, forKey: "numberMessage")
        aCoder.encode(numberSeat, forKey: "numberSeat")
        aCoder.encode(numberQuestion, forKey: "numberQuestion")
    }
    
    static func saveNotice(noice: NoticeMember) {
        let encodeData = NSKeyedArchiver.archivedData(withRootObject: noice)
        UserDefaults.standard.set(encodeData, forKey: "myNotice")
    }
    
    static func getNotice() -> NoticeMember {
        if let data = UserDefaults.standard.data(forKey: "myNotice"),
            let myNotice = NSKeyedUnarchiver.unarchiveObject(with: data) as? NoticeMember {
            return myNotice
        }
        let myNotice = NoticeMember(numberMessage: 0, numberSeat: 0, numberQuestion: 0)
        return myNotice
    }
}
