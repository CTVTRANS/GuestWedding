//
//  SeatViewController.swift
//  GuestWedding
//
//  Created by Kien on 10/31/17.
//  Copyright © 2017 Kien. All rights reserved.
//

import UIKit

class SeatViewController: BaseViewController {

    @IBOutlet weak var nameCompany: UILabel!
    @IBOutlet weak var aceptButton: UIButton!
    @IBOutlet weak var openLinkWeb: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        aceptButton.layer.borderColor = UIColor.rgb(248, 54, 123).cgColor
        openLinkWeb.layer.borderColor = UIColor.rgb(248, 54, 123).cgColor
        titleLabel.layer.borderColor = UIColor.rgb(248, 54, 123).cgColor
        setupNavigation()
        nameCompany.text = Member.shared.nameCompany
    }
    
    @IBAction func pressedOpenWeb(_ sender: Any) {
        let urlSeatImage = Member.shared.imageOfSeat
        UIApplication.shared.openURL(URL(string: urlSeatImage)!)
    }
    
    @IBAction func pressedAcept(_ sender: Any) {
        if let url = URL(string: Member.shared.linkweb + "&index=11") {
            UIApplication.shared.openURL(url)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
