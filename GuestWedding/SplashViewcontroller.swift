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
        let guest = guestCache.fetchObject()
        guard guest != nil, guest?.account != "" else {
            if let vc = storyboard?.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController {
                self.present(vc, animated: false, completion: nil)
            }
            return
        }
        if let vc = storyboard?.instantiateViewController(withIdentifier: "SWRevealViewController") as? SWRevealViewController {
            self.present(vc, animated: false, completion: nil)
        }
    }
}
