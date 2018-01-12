//
//  SplashViewcontroller.swift
//  GuestWedding
//
//  Created by le kien on 12/26/17.
//  Copyright © 2017 Kien. All rights reserved.
//

import UIKit
import SWRevealViewController

class SplashViewcontroller: BaseViewController {

    override func viewDidLoad() {
        let guestCache = Cache<Guest>()
        let memberCache = Cache<Member>()
        let guest = guestCache.fetchObject()
        let member = memberCache.fetchObject()
        guard guest != nil, guest?.account != "", member != nil, member?.idMember != "" else {
            if let vc = storyboard?.instantiateViewController(withIdentifier: "SiginViewController") as? SiginViewController {
                navigationController?.pushViewController(vc, animated: false)
            }
            return
        }
        Member.shared = memberCache.fetchObject()!
        Guest.shared = guest!
        if let vc = storyboard?.instantiateViewController(withIdentifier: "SWRevealViewController") as? SWRevealViewController {
            self.present(vc, animated: false, completion: nil)
        }
    }
}

extension Date {
    static func convertToDateWith(timeInt: String, withFormat: String) -> Date? {
        let dateFomater = DateFormatter()
        dateFomater.dateFormat = withFormat
        let date = dateFomater.date(from: timeInt)
        return date
    }
    
    static func convert(date: Date, toString timeOut: String) -> String {
        let dateFomater = DateFormatter()
        dateFomater.dateFormat = timeOut
        let dateString = dateFomater.string(from: date)
        return dateString
    }
}
