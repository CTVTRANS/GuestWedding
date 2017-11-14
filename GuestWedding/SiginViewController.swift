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

    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var userName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userName.layer.borderColor = UIColor.rgb(233, 130, 139).cgColor
        password.layer.borderColor = UIColor.rgb(233, 130, 139).cgColor
    }
    
    func getMessage() {
        let notice = NoticeMember.getNotice()
        let member = Contants.shared.currentMember!
        let getMessageTask = GetMessageTask(userID: (member.idMember)!, page: 0)
        self.requestWith(task: getMessageTask) { (data) in
            if let arrayMessage = data as? [Message] {
                let oldNumberMessage: Int = notice.numberMessage!
                Contants.shared.numberNewMessage = arrayMessage.count - oldNumberMessage
                Contants.shared.totalMessage = arrayMessage.count
                if let vc = self.storyboard?.instantiateViewController(withIdentifier: "SWRevealViewController") as? SWRevealViewController {
                    self.present(vc, animated: false, completion: nil)
                }
            }
        }
        let newNumberSeat = member.numberGuestMan! + member.numberGuestWoman!
        let oldNumberSeat = notice.numberSeat!
        Contants.shared.numberNewSeat = newNumberSeat - oldNumberSeat
        Contants.shared.totalSeat = newNumberSeat
    }

    @IBAction func pressedSigin(_ sender: Any) {
        let siginTask = SiginTask(idGuest: "0912345678")
        requestWith(task: siginTask) { (data) in
            if let data = data as? (Guest, [Member]) {
                let guest = data.0
                Guest.shared = guest
                Contants.shared.currentMember = data.1.first
                if  Contants.shared.currentMember != nil {
                    self.getMessage()
                    return
                }
                
                if let vc = self.storyboard?.instantiateViewController(withIdentifier: "SWRevealViewController") as? SWRevealViewController {
                    self.present(vc, animated: false, completion: nil)
                }
            }
        }
    }
}
