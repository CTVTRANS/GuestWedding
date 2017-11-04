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
    var member: Member?
    var listMessage: [Message] = []
    var tap: UITapGestureRecognizer?
    
    var popView: SetupProfile!
    let picker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        table.estimatedRowHeight = 140
        setupNavigation()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_back"), style: .plain, target: self, action: #selector(popViewController))
        getMessage()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardNotification(notification:)),
                                               name: NSNotification.Name.UIKeyboardWillChangeFrame,
                                               object: nil)
        picker.delegate = self
        popView = SetupProfile.instance() as? SetupProfile
    }
    
    func popViewController() {
        navigationController?.popViewController(animated: false)
    }
    
    func getMessage() {
        let getMessageTask = GetMessageTask(idGuest: Guest.shared.idGuest!, userID: (member?.idMember)!)
        requestWith(task: getMessageTask) { (data) in
            if let arrayMessage = data as? [Message] {
                self.listMessage = arrayMessage
                self.table.reloadData()
                self.scrollLastMessage()
            }
        }
    }
    
    func scrollLastMessage() {
        DispatchQueue.main.async {
            let contensizeHight = self.table.contentSize.height
            let frameHight = self.table.frame.size.height
            if contensizeHight > frameHight {
                let offset = CGPoint(x: 0, y: contensizeHight - frameHight)
                self.table.setContentOffset(offset, animated: false)
            }
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
            DispatchQueue.main.async(execute: {
                self.scrollLastMessage()
            })
        }
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
        view.removeGestureRecognizer(tap!)
    }
    
    @IBAction func pressedUpdateProfile(_ sender: Any) {
        popView?.show()
        popView?.callBack = { [unowned self] in
            self.pickPhoto()
        }
    }
    
    @IBAction func pressedSendMsg(_ sender: Any) {
        
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
        
        let timeMessage = String(month) + "/" + String(date) + " " + (timeHour?.substring(to: index!))!
        time.text = timeMessage
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
        
        let timeMessage = String(month) + "/" + String(date) + " " + (timeHour?.substring(to: index!))!
        time.text = timeMessage
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
        if message.isMyOwner {
           return myCellMsg(indexPath: indexPath)
        } else {
            return memberCellMsg(indexPath: indexPath)
        }
    }
}

extension DetailChatViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func pickPhoto() {
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
            })
        }
    }
}
