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
    
    @IBAction func pressedSearch(_ sender: Any) {
        let task = FindMember(nameSearch: nameMember.text!)
        requestWith(task: task, success: { (data) in
            debugPrint(data)
        }) { (error) in
            UIAlertController.showAlertWith(title: "", message: error, in: self)
        }
    }
    
    @IBAction func pressedFlow(_ sender: Any) {
        if nameMember.text != nil {
            let followMember = AddMemberTask(member: nameMember.text!)
            requestWith(task: followMember, success: { (data) in
                if let member = data as? Member {
                    Contants.shared.currentMember = member
                    self.navigationController?.popViewController(animated: true)
                }
            }, failure: { (error) in
                UIAlertController.showAlertWith(title: "", message: error, in: self)
            })
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
