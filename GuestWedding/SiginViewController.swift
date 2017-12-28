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
    
    func getMessage() {
        let notice = NoticeMember.getNotice()
        let member = Contants.shared.currentMember!
        let getMessageTask = GetMessageTask(userID: (member.idMember), page: 0, limit: 30)
        requestWith(task: getMessageTask, success: { (data) in
            if let arrayMessage = data as? [Message] {
                let oldNumberMessage: Int = notice.numberMessage!
                for index in 0..<arrayMessage.count - oldNumberMessage where !arrayMessage[index].isMyOwner {
                    Contants.shared.numberNewMessage += 1
                }
                Contants.shared.totalMessage = arrayMessage.count
                if let vc = self.storyboard?.instantiateViewController(withIdentifier: "SWRevealViewController") as? SWRevealViewController {
                    self.present(vc, animated: false, completion: nil)
                }
            }
        }) { (_) in
            
        }

        let newNumberSeat = member.numberGuestMan + member.numberGuestWoman
        let oldNumberSeat = notice.numberSeat!
        Contants.shared.numberNewSeat = abs(newNumberSeat - oldNumberSeat)
        Contants.shared.totalSeat = newNumberSeat
    }

    @IBAction func pressedSigin(_ sender: Any) {
        showActivity(inView: self.view)
        let siginTask = SiginTask(idGuest: emailGuest.text!, nameMember: nameMember.text!)
        requestWith(task: siginTask, success: { (memberAccount) in
            guard let memberAccount = memberAccount as? String else {
                return
            }
            
            let task = GetInfo(idGuest: self.emailGuest.text!, nameMember: memberAccount)
            self.requestWith(task: task, success: { (data) in
                if let data = data as? (Guest, Member) {
                    let guest = data.0
                    Guest.shared = guest
                    let caheGuest = Cache<Guest>()
                    caheGuest.save(object: guest)
                    let caheMember = Cache<Member>()
                    caheMember.save(object: data.1)
                    Contants.shared.currentMember = data.1
                    self.stopActivityIndicator()
                    self.getMessage()
                }
            }, failure: { (error) in
                self.stopActivityIndicator()
                UIAlertController.showAlertWith(title: "", message: error, in: self)
            })
        }) { (error) in
            self.stopActivityIndicator()
            UIAlertController.showAlertWith(title: "", message: error, in: self)
        }
    }
}
