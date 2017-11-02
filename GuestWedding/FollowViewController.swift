//
//  FollowViewController.swift
//  GuestWedding
//
//  Created by Kien on 10/31/17.
//  Copyright © 2017 Kien. All rights reserved.
//

import UIKit

class FollowViewController: BaseViewController {

    @IBOutlet weak var nameMember: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        nameMember.layer.borderColor = UIColor.rgb(248, 54, 123).cgColor
        setupNavigation()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
