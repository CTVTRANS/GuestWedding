//
//  MainViewController.swift
//  GuestWedding
//
//  Created by Kien on 10/31/17.
//  Copyright © 2017 Kien. All rights reserved.
//

import UIKit
import SwiftyJSON

class MainViewController: BaseViewController {
    @IBOutlet weak var nameCompany: UILabel!
    @IBOutlet weak var nameMan: UILabel!
    @IBOutlet weak var nameWoman: UILabel!
    @IBOutlet weak var dateMan: UILabel!
    @IBOutlet weak var dateWoman: UILabel!
    @IBOutlet weak var counDownMan: UILabel!
    @IBOutlet weak var counDownWoman: UILabel!
    
    @IBOutlet weak var viewMessage: UIView!
    @IBOutlet weak var numberMessage: UILabel!
    @IBOutlet weak var viewSeat: UIView!
    @IBOutlet weak var numberSeat: UILabel!
    @IBOutlet weak var viewQuestion: UIView!
    @IBOutlet weak var numberQuestion: UILabel!
    
    var isNewMessage: Bool = false {
        didSet {
            viewMessage.isHidden = !self.isNewMessage
        }
    }
    var isNewSeat: Bool = false {
        didSet {
            viewSeat.isHidden = !self.isNewSeat
        }
    }
    var isNewQuestion: Bool = false {
        didSet {
            viewQuestion.isHidden = !self.isNewQuestion
        }
    }
    
    var member: Member!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_rightButton"), style: .plain, target: self, action: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadNumberNotification(notification:)), name: NSNotification.Name(rawValue: "refreshNotification"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        member = Contants.shared.currentMember
        setupUI()
        setupNotice()
    }
    
    func setupUI() {
        nameMan.text = member?.manName
        nameWoman.text = member?.nameWoman
        dateMan.text = member?.dateMan
        dateWoman.text = member?.dateWoman
        counDownMan.text = member?.counterManDate
        counDownWoman.text = member?.counterWomanDate
        let strokeTextDate: [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.strokeColor: UIColor.rgb(255, 80, 167),
            NSAttributedStringKey.strokeWidth: -3.0
            ]
        
        let strokeTextCountDonwn: [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.strokeColor: UIColor.white,
            NSAttributedStringKey.strokeWidth: -3.0
            ]
        dateMan.attributedText = NSAttributedString(string: dateMan.text!, attributes: strokeTextDate)
        dateWoman.attributedText = NSAttributedString(string: dateWoman.text!, attributes: strokeTextDate)
        counDownMan.attributedText = NSAttributedString(string: counDownMan.text!, attributes: strokeTextCountDonwn)
        counDownWoman.attributedText = NSAttributedString(string: counDownWoman.text!, attributes: strokeTextCountDonwn)
    }
    
    @objc func reloadNumberNotification(notification: Notification) {
       setupNotice()
    }
    
    func setupNotice() {
        let messageNumber = Contants.shared.numberNewMessage
        let seatNumber = Contants.shared.numberNewSeat
        let questionNumber = Contants.shared.numberNewQuestion
        isNewMessage = (messageNumber > 0) ? true : false
        numberMessage.text = (messageNumber > 9) ? "9" : String(messageNumber)
        
        isNewSeat = (seatNumber > 0) ? true : false
        numberSeat.text = (seatNumber > 9) ? "9" : String(seatNumber)
        
        isNewQuestion = (questionNumber > 0) ? true : false
        numberQuestion.text = (questionNumber > 9) ? "9" : String(questionNumber)
    }
    
    @IBAction func pressedOpenWeb(_ sender: Any) {
        let url = URL(string: (member?.linkweb)!)
        UIApplication.shared.openURL(url!)
    }
    
    @IBAction func pressedMessage(_ sender: Any) {
        let notice = NoticeMember.getNotice()
        notice.numberMessage = Contants.shared.totalMessage
        Contants.shared.numberNewMessage = 0
        isNewMessage = false
        NoticeMember.saveNotice(noice: notice)
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DetailChatViewController") as? DetailChatViewController {
            vc.member = Contants.shared.currentMember
            navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    @IBAction func pressedShowSeat(_ sender: Any) {
        let notice = NoticeMember.getNotice()
        notice.numberSeat = Contants.shared.totalSeat
        Contants.shared.numberNewSeat = 0
        isNewSeat = false
        NoticeMember.saveNotice(noice: notice)
        if let vc = storyboard?.instantiateViewController(withIdentifier: "SeatViewController") as? SeatViewController {
            navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    @IBAction func pressedQAWeb(_ sender: Any) {
        
    }

    @IBAction func pressedShowFolow(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "FollowViewController") as? FollowViewController {
            navigationController?.pushViewController(vc, animated: false)
        }
    }
}
