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
    
    @IBAction func pressedOpenWebSeat(_ sender: Any) {
        let urlSeatImage = "http://www.freewed.com.tw/app/love.aspx?ACCT=\(Member.shared.idMember)&index=13"
        if let url = URL(string: urlSeatImage) {
            UIApplication.shared.openURL(url)
        }
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
