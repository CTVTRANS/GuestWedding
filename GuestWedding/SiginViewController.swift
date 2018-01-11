//
//  SiginViewController.swift
//  GuestWedding
//
//  Created by Kien on 10/31/17.
//  Copyright © 2017 Kien. All rights reserved.
//

import UIKit
import SWRevealViewController

class SiginViewController: BaseViewController {

    @IBOutlet weak var nameMember: UITextField!
    @IBOutlet weak var emailGuest: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameMember.layer.borderColor = UIColor.rgb(233, 130, 139).cgColor
        emailGuest.layer.borderColor = UIColor.rgb(233, 130, 139).cgColor
    }

    @IBAction func pressedSigin(_ sender: Any) {
        showActivity(inView: self.view)
        let siginTask = SiginTask(idGuest: emailGuest.text!, nameMember: nameMember.text!)
        requestWith(task: siginTask, success: { (memberAccount) in
            guard let memberAccount = memberAccount as? String else {
                return
            }
            Guest.shared.account = self.emailGuest.text!
            Member.shared.idMember = memberAccount
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "SWRevealViewController") as? SWRevealViewController {
                self.present(vc, animated: false, completion: nil)
            }
        }) { (error) in
            self.stopActivityIndicator()
            UIAlertController.showAlertWith(title: "", message: error, in: self)
        }
    }
}
