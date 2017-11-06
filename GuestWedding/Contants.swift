//
//  Notice.swift
//  GuestWedding
//
//  Created by le kien on 11/6/17.
//  Copyright © 2017 Kien. All rights reserved.
//

import UIKit

class Contants {
    var numberNewMessage: Int = 0
    var numberNewSeat: Int = 0
    var numberNewQuestion: Int = 0
    
    var totalMessage: Int = 0
    var totalSeat: Int = 0
    var totalQuestion: Int = 0
    
    var currentMember: Member?
    
    static let shared = Contants()
    private init() {}
}
