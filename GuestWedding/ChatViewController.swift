//
//  ChatViewController.swift
//  GuestWedding
//
//  Created by Kien on 10/31/17.
//  Copyright © 2017 Kien. All rights reserved.
//

import UIKit

class ChatViewController: BaseViewController {

    @IBOutlet weak var table: UITableView!
    
    var listMember: [Member] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.tableFooterView = UIView()
        table.estimatedRowHeight = 140
        setupNavigation()
        getMember()
    }
    
    func getMember() {
        let getInfo = SiginTask(idGuest: Guest.shared.account!)
        requestWith(task: getInfo) { (data) in
            if let data = data as? (Guest, [Member]) {
                self.listMember = data.1
                self.table.reloadData()
            }
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

class MemberCell: UITableViewCell {
    
    @IBOutlet weak var numberMsg: UILabel!
    @IBOutlet weak var heightForAvatar: NSLayoutConstraint!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var contentMsg: UILabel!
    @IBOutlet weak var nameMember: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    
    override func awakeFromNib() {
        avatar.layer.cornerRadius = heightForAvatar.constant / 2
    }
    
    func binData(member: Member) {
        nameMember.text = member.nameMember
        let getNewestMessage = GetMessageTask(userID: member.idMember!, page: 0)
        getNewestMessage.requestServer(sucess: { (data) in
            if let listMessage = data as? [Message] {
                if listMessage.last != nil {
                    let newestMessage = listMessage.last!
                    self.contentMsg.text = newestMessage.messageBoby
                    let timeDate = newestMessage.time?.components(separatedBy: "T")[0]
                    let month: Int = Int((timeDate?.components(separatedBy: "-")[1])!)!
                    let date: Int = Int((timeDate?.components(separatedBy: "-")[2])!)!
                    self.time.text = String(month) + "/" + String(date)
                }
            }
        }) { (_) in
           
        }
    }
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listMember.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MemberCell
        cell?.binData(member: listMember[indexPath.row])
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.deselectRow(at: indexPath, animated: true)
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DetailChatViewController") as? DetailChatViewController {
            vc.member = listMember[indexPath.row]
            navigationController?.pushViewController(vc, animated: false)
        }
    }
}
