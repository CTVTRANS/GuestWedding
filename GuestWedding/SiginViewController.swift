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
        if emailGuest.text != "" {
            let siginTask = SiginTask(idGuest: emailGuest.text!, nameMember: nameMember.text!)
            requestWith(task: siginTask, success: { (memberAccount) in
                Guest.shared.account = self.emailGuest.text!
                guard let member = memberAccount as? String, member != "" else {
                    self.stopActivityIndicator()
                    if let vc = self.storyboard?.instantiateViewController(withIdentifier: "SWRevealViewController") as? SWRevealViewController,
                        let followVC = self.storyboard?.instantiateViewController(withIdentifier: "FollowViewController") as? FollowViewController {
                        self.present(vc, animated: false, completion: {
                            let navigationVC = vc.frontViewController as? UINavigationController
                            navigationVC?.pushViewController(followVC, animated: false)
                            vc.pushFrontViewController(navigationVC, animated: false)
                            navigationVC?.navigationItem.leftBarButtonItem?.isEnabled = false
                            navigationVC?.navigationItem.rightBarButtonItem?.isEnabled = false
                        })
                    }
                    return
                }
                Member.shared.idMember = member
                if let vc = self.storyboard?.instantiateViewController(withIdentifier: "SWRevealViewController") as? SWRevealViewController {
                    self.present(vc, animated: false, completion: nil)
                }
            }) { (error) in
                self.stopActivityIndicator()
                UIAlertController.showAlertWith(title: "", message: error, in: self)
            }
        } else {
            self.stopActivityIndicator()
            UIAlertController.showAlertWith(title: "", message: "電話號碼或者Email不能空白", in: self)
        }
    }
}
