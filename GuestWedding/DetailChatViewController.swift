//
//  DetailChatViewController.swift
//  GuestWedding
//
//  Created by Kien on 10/31/17.
//  Copyright © 2017 Kien. All rights reserved.
//

import UIKit

class DetailChatViewController: BaseViewController {
    
    @IBOutlet weak var bottomContraint: NSLayoutConstraint!
    @IBOutlet weak var textMessage: UITextView!
    @IBOutlet weak var table: UITableView!
    
    var member = Member.shared
    var listMessage: [Message] = []
    var tap: UITapGestureRecognizer?
    private var avatar: NSData?
    
    private var popView: SetupProfile!
    private let picker = UIImagePickerController()
    private var page: Int = 1
    private var isLoading = false
    private var isMoreData = true
    private var isScrollTop = false
    private var firstGoToView = true
    private var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showActivity(inView: self.view)
        table.estimatedRowHeight = 140
        setupNavigation()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_back"), style: .plain, target: self, action: #selector(popViewController))
        getMessage()
        setupKeyboard()
        NotificationCenter.default.addObserver(self, selector: #selector(getNewsMessage), name: Notification.Name("recivePush"), object: nil)
        picker.delegate = self
        popView = SetupProfile.instance() as? SetupProfile
        timer = Timer.scheduledTimer(timeInterval: 120, target: self, selector: #selector(reGetMessage), userInfo: nil, repeats: true)
    }
    
    func setupKeyboard() {
        textMessage.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
    }
    
    @objc func popViewController() {
        navigationController?.popViewController(animated: false)
    }
    
    @objc func getNewsMessage() {
        self.isMoreData = true
        self.listMessage.removeAll()
        self.page = 1
        self.getMessage()
    }
    
    func getMessage() {
        let getMessageTask = GetMessageTask( userID: member.idMember, page: page, limit: 30)
        requestWith(task: getMessageTask, success: { (data) in
            if let arrayMessage = data as? [Message] {
                self.isLoading = false
                if arrayMessage.count == 0 {
                    self.isMoreData = false
                }
                self.listMessage.insert(contentsOf: arrayMessage.reversed(), at: 0)
                self.table.reloadData()
                if self.isScrollTop {
                    let index = IndexPath(row: arrayMessage.count, section: 0)
                    self.table.scrollToRow(at: index, at: .top, animated: false)
                    
                } else {
                    if self.firstGoToView {
                        self.firstGoToView = false
                        self.scrollLastMessage(animated: false)
                    } else {
                        self.scrollLastMessage(animated: true)
                    }
                }
            }
        }) { (error) in
            UIAlertController.showAlertWith(title: "", message: error, in: self)
        }
    }
    
    func scrollLastMessage(animated: Bool) {
//        DispatchQueue.main.async {
            if self.listMessage.count > 0 {
                let index = IndexPath(row: self.listMessage.count - 1, section: 0)
                self.table.scrollToRow(at: index, at: .bottom, animated: animated)
            }
            self.stopActivityIndicator()
//        }
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap!)
        self.navigationItem.leftBarButtonItem?.isEnabled = false
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            bottomContraint.constant = keyboardRectangle.height
        }
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        self.navigationItem.leftBarButtonItem?.isEnabled = true
        self.navigationItem.rightBarButtonItem?.isEnabled = true
        bottomContraint.constant = 0.0
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
        view.removeGestureRecognizer(tap!)
    }
    
    func showUpdateView() {
        popView?.show()
        popView?.callBack = { [unowned self] in
            self.pickPhoto()
        }
        popView.changeProfile = { [unowned self] (name) in
            let update = UpdateGuestInfo(data: self.avatar, username: name, mobile: "", email: "")
            self.upLoas(task: update, success: { (_) in
                let task = GetInfo(idGuest: Guest.shared.account, nameMember: Member.shared.idMember)
                self.requestWith(task: task, success: { (data) in
                    if let data = data as? (Guest, Member) {
                        let guest = data.0
                        Guest.shared = guest
                        let caheGuest = Cache<Guest>()
                        caheGuest.save(object: guest)
                        UIAlertController.showAlertWith(title: "", message: "成功更新", in: self)
                    }
                }, failure: { (_) in
                    
                })
            })
        }
    }
    
    @IBAction func pressedUpdateProfile(_ sender: Any) {
        showUpdateView()
    }
    
    @IBAction func pressedSendMsg(_ sender: Any) {
        guard Guest.shared.account != Guest.shared.usename, Int(Guest.shared.usename) == nil else {
            UIAlertController.showAlertWith(title: "", message: "名稱要設定好才能發訊息", in: self, compeletionHandler: {
                self.showUpdateView()
            })
            return
        }
        if textMessage.text != "" {
            isScrollTop = false
            let message = textMessage.text
            self.textMessage.text = ""
            scrollLastMessage(animated: true)
            let sendMessageTask = SendMessageTask(msg: message!)
            requestWith(task: sendMessageTask, success: { (_) in
                self.getNewsMessage()
            }, failure: { (_) in
                
            })
        }
    }
    
    deinit {
        timer?.invalidate()
        timer = nil
        NotificationCenter.default.removeObserver(self)
    }
}

class MyCellMessage: UITableViewCell {
    
    @IBOutlet weak var test: UIImageView!
    @IBOutlet weak var contentMsg: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var heightOfStatus: NSLayoutConstraint!
    
    override func awakeFromNib() {
        test.tintColor = UIColor.green
    }
    
    func binData(message: Message) {
        contentMsg.text = message.messageBoby
        let date = Date.convertToDateWith(timeInt: message.time, withFormat: "yyyy-MM-dd'T'HH-mm-ss")
        let timeMessage = Date.convert(date: date!, toString: "MM/dd HH:mm")
        time.text = timeMessage
    }
}

class MemberCellMessage: UITableViewCell {
    
    @IBOutlet weak var contentMsg: UILabel!
    @IBOutlet weak var time: UILabel!
    
    func binData(message: Message) {
        contentMsg.text = message.messageBoby
        let date = Date.convertToDateWith(timeInt: message.time, withFormat: "yyyy-MM-dd'T'HH-mm-ss")
        let timeMessage = Date.convert(date: date!, toString: "MM/dd HH:mm")
        time.text = timeMessage
    }
}

extension DetailChatViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listMessage.count
    }
    
    func myCellMsg(indexPath: IndexPath, myMessage: Message) -> MyCellMessage {
        let cell = table.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as? MyCellMessage
        cell?.binData(message: myMessage)
        if indexPath.row == (listMessage.count - 1) {
            cell?.status.isHidden = false
            cell?.heightOfStatus.constant = 14.5
            if myMessage.isRead {
                cell?.status.text = "已讀"
            } else {
                cell?.status.text = "未讀"
            }
        } else {
            cell?.status.isHidden = true
            cell?.heightOfStatus.constant = 0
        }
        return cell!
    }
    
    func memberCellMsg(indexPath: IndexPath, memBerMessage: Message) -> MemberCellMessage {
        let cell = table.dequeueReusableCell(withIdentifier: "memberCell", for: indexPath) as? MemberCellMessage
        cell?.binData(message: memBerMessage)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = listMessage[indexPath.row]
        if message.isMyOwner {
           return myCellMsg(indexPath: indexPath, myMessage: message)
        } else {
            return memberCellMsg(indexPath: indexPath, memBerMessage: message)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let isTop = table.contentOffset.y <= 10.0 ? true : false
        if isTop && isMoreData && !isLoading && !scrollView.isDragging {
            page += 1
            isLoading = true
            isScrollTop = true
            getMessage()
        }
    }
}

extension DetailChatViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func pickPhoto() {
        picker.navigationBar.tintColor = UIColor.blue
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        picker.modalPresentationStyle = .custom
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        if let chooseImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            dismiss(animated: true, completion: { [unowned self] in
                self.popView.avatar.image = chooseImage
                if let data = UIImageJPEGRepresentation(chooseImage, 0.8) as NSData? {
                     self.avatar = data
                }
            })
        }
    }
}

extension DetailChatViewController: UITextViewDelegate {
    
    @objc func reGetMessage() {
        let getMessageTask = GetMessageTask( userID: member.idMember, page: 1, limit: listMessage.count)
        requestWith(task: getMessageTask, success: { (data) in
            guard let list = data as? [Message] else {
                return
            }
            self.listMessage.removeAll()
            self.listMessage.append(contentsOf: list.reversed())
            self.table.reloadData()
        }) { (_) in
            
        }
        
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        let task = UpdateStatusMessage(idMember: member.idMember)
        requestWith(task: task, success: { (_) in
        }) { (_) in
        }
        return true
    }
}
