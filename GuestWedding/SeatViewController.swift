//
//  SeatViewController.swift
//  GuestWedding
//
//  Created by Kien on 10/31/17.
//  Copyright © 2017 Kien. All rights reserved.
//

import UIKit

class SeatViewController: BaseViewController {

    @IBOutlet weak var aceptButton: UIButton!
    @IBOutlet weak var openLinkWeb: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        aceptButton.layer.borderColor = UIColor.rgb(248, 54, 123).cgColor
        openLinkWeb.layer.borderColor = UIColor.rgb(248, 54, 123).cgColor
        titleLabel.layer.borderColor = UIColor.rgb(248, 54, 123).cgColor
        setupNavigation()
    }
    
    @IBAction func pressedOpenWeb(_ sender: Any) {
//        UIApplication.shared.openURL(URL(string: "")!)
    }
    
    @IBAction func pressedAcept(_ sender: Any) {
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
