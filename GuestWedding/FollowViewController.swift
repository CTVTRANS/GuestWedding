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
        nameMember.delegate = self
        nameMember.layer.borderColor = UIColor.rgb(248, 54, 123).cgColor
        setupNavigation()
    }
    
    @IBAction func pressedSearch(_ sender: Any) {
        nameMember.endEditing(true)
        showActivity(inView: self.view)
        if nameMember.text != "" {
            let task = FindMember(nameSearch: nameMember.text!)
            requestWith(task: task, success: { (data) in
                self.stopActivityIndicator()
                guard let memberList = data as? [Member] else {
                    return
                }
                let listView = SearchMember.instance() as? SearchMember
                listView?.listmember = memberList
                listView?.table.reloadData()
                listView?.show()
                listView?.callBack = { [unowned self] memberSeleted in
                    self.nameMember.text = memberSeleted?.idMember
                    listView?.hide()
                }
            }) { (error) in
                self.stopActivityIndicator()
                UIAlertController.showAlertWith(title: "", message: error, in: self)
            }
        } else {
            UIAlertController.showAlertWith(title: "", message: "name account cant emty", in: self)
        }
    }
    
    @IBAction func pressedFlow(_ sender: Any) {
        if nameMember.text != "" {
            let followMember = AddMemberTask(member: nameMember.text!)
            requestWith(task: followMember, success: { (data) in
                if let member = data as? Member {
                    Member.shared = member
                    let memberCache = Cache<Member>()
                    memberCache.remove()
                    memberCache.save(object: member)
                    self.navigationController?.popViewController(animated: true)
                }
            }, failure: { (error) in
                UIAlertController.showAlertWith(title: "", message: error, in: self)
            })
        } else {
            UIAlertController.showAlertWith(title: "", message: "name account cant emty", in: self)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension FollowViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.endEditing(true)
    }
}
