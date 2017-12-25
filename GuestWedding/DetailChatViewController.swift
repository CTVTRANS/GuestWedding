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
    
    var member = Contants.shared.currentMember
    var listMessage: [Message] = []
    var tap: UITapGestureRecognizer?
    fileprivate var avatar: NSData?
    
    fileprivate var popView: SetupProfile!
    fileprivate let picker = UIImagePickerController()
    fileprivate var page: Int = 1
    fileprivate var isLoading = false
    fileprivate var isMoreData = true
    fileprivate var isScrollTop = false
    fileprivate var firstGoToView = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showActivity(inView: self.view)
        table.estimatedRowHeight = 140
        setupNavigation()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_back"), style: .plain, target: self, action: #selector(popViewController))
        getMessage()
        NotificationCenter.default.addObserver(self, selector: #selector(getNewsMessage), name: Notification.Name("requestToServer"), object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardNotification(notification:)),
                                               name: NSNotification.Name.UIKeyboardWillChangeFrame,
                                               object: nil)
        picker.delegate = self
        popView = SetupProfile.instance() as? SetupProfile
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
        let getMessageTask = GetMessageTask( userID: (member?.idMember)!, page: page)
        requestWith(task: getMessageTask) { (data) in
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
        }
    }
    
    func scrollLastMessage(animated: Bool) {
        DispatchQueue.main.async {
            if self.listMessage.count > 0 {
                let index = IndexPath(row: self.listMessage.count - 1, section: 0)
                self.table.scrollToRow(at: index, at: .bottom, animated: animated)
            }
            self.stopActivityIndicator()
        }
    }
    
    @objc func keyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let duration: TimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIViewAnimationOptions.curveEaseInOut.rawValue
            let animationCurve: UIViewAnimationOptions = UIViewAnimationOptions(rawValue: animationCurveRaw)
            if (endFrame?.origin.y)! >= UIScreen.main.bounds.size.height {
                self.navigationItem.leftBarButtonItem?.isEnabled = true
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                
                bottomContraint.constant = 0.0
            } else {
                tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
                view.addGestureRecognizer(tap!)
                self.navigationItem.leftBarButtonItem?.isEnabled = false
                self.navigationItem.rightBarButtonItem?.isEnabled = false
                bottomContraint.constant = (endFrame?.size.height)!
            }
            UIView.animate(withDuration: duration,
                           delay: TimeInterval(0),
                           options: animationCurve,
                           animations: { self.view.layoutIfNeeded() },
                           completion: nil)
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
        view.removeGestureRecognizer(tap!)
    }
    
    @IBAction func pressedUpdateProfile(_ sender: Any) {
        popView?.show()
        popView?.callBack = { [unowned self] in
            self.pickPhoto()
        }
        popView.changeProfile = { [unowned self] (name) in
            let update = UpdateGuestInfo(data: self.avatar, username: name, mobile: nil, email: nil)
            self.upLoas(task: update, success: { (data) in
                if let msg = data as? String {
                    debugPrint(msg)
                }
            })
        }
    }
    
    @IBAction func pressedSendMsg(_ sender: Any) {
        if textMessage.text != nil {
            isScrollTop = false
            let message = textMessage.text
            self.textMessage.text = ""
            scrollLastMessage(animated: true)
            let sendMessageTask = SendMessageTask(msg: message!)
            requestWith(task: sendMessageTask) { (_) in
                self.getNewsMessage()
            }
        }
    }
}

class MyCellMessage: UITableViewCell {
    
    @IBOutlet weak var contentMsg: UILabel!
    @IBOutlet weak var time: UILabel!
    
    func binData(message: Message) {
        contentMsg.text = message.messageBoby
        let timeDate = message.time?.components(separatedBy: "T")
        let month: Int = Int(timeDate![0].components(separatedBy: "-")[1])!
        let date: Int = Int(timeDate![0].components(separatedBy: "-")[2])!
        
        let timeHour = timeDate?[1]
        let index = timeHour?.index((timeHour?.startIndex)!, offsetBy: 4)
        
        let timeMessage = String(month) + "/" + String(date)
        time.text = timeMessage + " " + String((timeHour?[...index!])!)
    }
}

class MemberCellMessage: UITableViewCell {
    
    @IBOutlet weak var contentMsg: UILabel!
    @IBOutlet weak var time: UILabel!
    
    func binData(message: Message) {
        contentMsg.text = message.messageBoby
        let timeDate = message.time?.components(separatedBy: "T")
        let month: Int = Int(timeDate![0].components(separatedBy: "-")[1])!
        let date: Int = Int(timeDate![0].components(separatedBy: "-")[2])!
        
        let timeHour = timeDate?[1]
        let index = timeHour?.index((timeHour?.startIndex)!, offsetBy: 4)
        
        let timeMessage = String(month) + "/" + String(date)
        time.text = timeMessage + " " + String((timeHour?[...index!])!)
    }
}

extension DetailChatViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listMessage.count
    }
    
    func myCellMsg(indexPath: IndexPath, myMessage: Message) -> MyCellMessage {
        let cell = table.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as? MyCellMessage
        cell?.binData(message: myMessage)
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
