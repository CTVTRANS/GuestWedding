//
//  DetailChatViewController.swift
//  GuestWedding
//
//  Created by Kien on 10/31/17.
//  Copyright © 2017 Kien. All rights reserved.
//

import UIKit

class DetailChatViewController: BaseViewController {
    
    @IBOutlet weak var textMessage: UITextView!
    @IBOutlet weak var table: UITableView!
    var member: Member?
    var listMessage: [Message] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        table.estimatedRowHeight = 140
        setupNavigation()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_back"), style: .plain, target: self, action: #selector(popView))
    }
    
    func popView() {
        navigationController?.popViewController(animated: false)
    }
    
    @IBAction func pressedUpdateProfile(_ sender: Any) {
        let popView = SetupProfile.instance() as? SetupProfile
        popView?.show()
    }
    
    @IBAction func pressedSendMsg(_ sender: Any) {
        
    }
}

class MyCellMessage: UITableViewCell {
    
    @IBOutlet weak var contentMsg: UILabel!
    @IBOutlet weak var time: UILabel!
    
    func binData(message: Message) {
        time.text = message.time?.components(separatedBy: " ")[0]
        contentMsg.text = message.messageBoby
    }
}

class MemberCellMessage: UITableViewCell {
    
    @IBOutlet weak var contentMsg: UILabel!
    @IBOutlet weak var time: UILabel!
    
    func binData(message: Message) {
        time.text = message.time?.components(separatedBy: " ")[0]
        contentMsg.text = message.messageBoby
    }
}

extension DetailChatViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listMessage.count
    }
    
    func myCellMsg(indexPath: IndexPath) -> MyCellMessage {
        let cell = table.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as? MyCellMessage
        cell?.binData(message: listMessage[indexPath.row])
        return cell!
    }
    
    func memberCellMsg(indexPath: IndexPath) -> MemberCellMessage {
        let cell = table.dequeueReusableCell(withIdentifier: "memberCell", for: indexPath) as? MemberCellMessage
        cell?.binData(message: listMessage[indexPath.row])
        return cell!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = listMessage[indexPath.row]
        if message.messageOwner == "me" {
           return myCellMsg(indexPath: indexPath)
        } else {
            return memberCellMsg(indexPath: indexPath)
        }
    }
}
