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
        if index == 0 || index == 4 {
            viewOfNotice.isHidden = true
        }
        if index == 1 {
            viewOfNotice.isHidden = !(messageNumber > 0) ? true : false
            numberNotice.text = (messageNumber > 9) ? "9" : String(messageNumber)
        }
        if index == 2 {
            viewOfNotice.isHidden = !(seatNumber > 0) ? true : false
            numberNotice.text = (seatNumber > 9) ? "9" : String(seatNumber)
        }
        if index == 3 {
            viewOfNotice.isHidden = !(questionNumber > 0) ? true : false
            numberNotice.text = (questionNumber > 9) ? "9" : String(questionNumber)
        }
        
    }
}

class LeftMenuViewController: BaseViewController {

    @IBOutlet weak var table: UITableView!
    var arrayMenu = ["邀約平台/貴賓回函", "新人快訊", "桌位圖發佈", "諮詢回覆", "重新追蹤新人"]
    let notificationName = Notification.Name("refreshNotification")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        table.reloadData()
    }
    @IBAction func pressedBackHome(_ sender: Any) {
        let navigationVC = swVC?.frontViewController as? UINavigationController
        navigationVC?.popToRootViewController(animated: false)
        swVC?.pushFrontViewController(navigationVC, animated: true)
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
            if let url = URL(string: Member.shared.linkweb) {
                UIApplication.shared.openURL(url)
            }
            swVC?.revealToggle(animated: true)
            return
        case 1:
            Contants.shared.numberNewMessage = 0
            NotificationCenter.default.post(name: notificationName, object: nil)
            vc = storyboard?.instantiateViewController(withIdentifier: "DetailChatViewController") as? DetailChatViewController
            let task = UpdateNotice(type: 1)
            requestWith(task: task, success: { (_) in}) { (_) in}
        case 2:
            Contants.shared.numberNewSeat = 0
            NotificationCenter.default.post(name: notificationName, object: nil)
            vc = storyboard?.instantiateViewController(withIdentifier: "SeatViewController") as? SeatViewController
            let task = UpdateNotice(type: 2)
            requestWith(task: task, success: { (_) in}) { (_) in}
        case 3:
            Contants.shared.numberNewQuestion = 0
            NotificationCenter.default.post(name: notificationName, object: nil)
            UIApplication.shared.openURL(URL(string: "http://www.freewed.com.tw/app/fac.aspx?ACCT=freewed")!)
            swVC?.revealToggle(animated: true)
            let task = UpdateNotice(type: 4)
            requestWith(task: task, success: { (_) in}) { (_) in}
            return
        case 4:
            vc = storyboard?.instantiateViewController(withIdentifier: "FollowViewController") as? FollowViewController
        default:
            break
        }
        navigationVC?.pushViewController(vc!, animated: false)
        swVC?.pushFrontViewController(navigationVC, animated: true)
    }
}
