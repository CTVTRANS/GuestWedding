//
//  LeftMenuViewController.swift
//  GuestWedding
//
//  Created by Kien on 10/31/17.
//  Copyright © 2017 Kien. All rights reserved.
//

import UIKit

class LeftMenuCell: UITableViewCell {
    
    @IBOutlet weak var viewOfNotice: UIView!
    @IBOutlet weak var numberNotice: UILabel!
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        viewOfNotice.isHidden = true
    }
    
    func binData(name: String, index: Int) {
        let messageNumber = Contants.shared.numberNewMessage
        let seatNumber = Contants.shared.numberNewSeat
        let questionNumber = Contants.shared.numberNewQuestion
        self.name.text = name
        if index == 0 || index == 1 || index == 5 {
            viewOfNotice.isHidden = true
        }
        if index == 2 {
            viewOfNotice.isHidden = !(messageNumber > 0) ? true : false
            numberNotice.text = (messageNumber > 9) ? "9" : String(messageNumber)
        }
        if index == 3 {
            viewOfNotice.isHidden = !(seatNumber > 0) ? true : false
            numberNotice.text = (seatNumber > 9) ? "9" : String(seatNumber)
        }
        if index == 4 {
            viewOfNotice.isHidden = !(questionNumber > 0) ? true : false
            numberNotice.text = (questionNumber > 9) ? "9" : String(questionNumber)
        }
        
    }
}

class LeftMenuViewController: BaseViewController {

    @IBOutlet weak var table: UITableView!
    var arrayMenu = ["row 1", "row2", "row3", "row4", "row5", "row6"]
    let notificationName = Notification.Name("refreshNotification")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        table.reloadData()
    }
}

extension LeftMenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? LeftMenuCell
        cell?.binData(name: arrayMenu[indexPath.row], index: indexPath.row)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.deselectRow(at: indexPath, animated: true)
        let navigationVC = swVC?.frontViewController as? UINavigationController
        var vc: BaseViewController? = nil
        switch indexPath.row {
        case 0:
            swVC?.revealToggle(animated: true)
            return
        case 1:
            UIApplication.shared.openURL(URL(string: (Contants.shared.currentMember?.linkweb)!)!)
            swVC?.revealToggle(animated: true)
            return
        case 2:
            Contants.shared.numberNewMessage = 0
            let notice = NoticeMember.getNotice()
            notice.numberMessage = Contants.shared.totalMessage
            NoticeMember.saveNotice(noice: notice)
            NotificationCenter.default.post(name: notificationName, object: nil)
            vc = storyboard?.instantiateViewController(withIdentifier: "ChatViewController") as? ChatViewController
        case 3:
            Contants.shared.numberNewSeat = 0
            let notice = NoticeMember.getNotice()
            notice.numberSeat = Contants.shared.totalSeat
            NoticeMember.saveNotice(noice: notice)
            NotificationCenter.default.post(name: notificationName, object: nil)
            vc = storyboard?.instantiateViewController(withIdentifier: "SeatViewController") as? SeatViewController
        case 4:
            Contants.shared.numberNewQuestion = 0
            let notice = NoticeMember.getNotice()
            notice.numberQuestion = Contants.shared.totalQuestion
            NoticeMember.saveNotice(noice: notice)
            NotificationCenter.default.post(name: notificationName, object: nil)
            UIApplication.shared.openURL(URL(string: "http://www.freewed.com.tw/app/fac.aspx?ACCT=freewed")!)
            swVC?.revealToggle(animated: true)
            return
        case 5:
            vc = storyboard?.instantiateViewController(withIdentifier: "FollowViewController") as? FollowViewController
        default:
            break
        }
        navigationVC?.pushViewController(vc!, animated: false)
        swVC?.pushFrontViewController(navigationVC, animated: true)
    }
}
