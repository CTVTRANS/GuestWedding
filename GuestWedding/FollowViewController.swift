//
//  FollowViewController.swift
//  GuestWedding
//
//  Created by Kien on 10/31/17.
//  Copyright © 2017 Kien. All rights reserved.
//

import UIKit

class FollowViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigation()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
