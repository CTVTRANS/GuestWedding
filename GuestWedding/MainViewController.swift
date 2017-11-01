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
    @IBOutlet weak var dateMan: OutlineLabel!
    @IBOutlet weak var dateWoman: OutlineLabel!
    @IBOutlet weak var countDownMan: OutlineLabel!
    @IBOutlet weak var countDownWoman: OutlineLabel!
    
    var member: Member?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_rightButton"), style: .plain, target: nil, action: nil)
        member = Member(json: JSON.null)
        Member.shared.linkweb = member?.linkweb
    }
    
    @IBAction func pressedOpenWeb(_ sender: Any) {
        let url = URL(string: (member?.linkweb)!)
        UIApplication.shared.openURL(url!)
    }
    
    @IBAction func pressedMessage(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "ChatViewController") as? ChatViewController {
            navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    @IBAction func pressedShowSeat(_ sender: Any) {
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

class OutlineLabel: UILabel {
    
    var outlineWidth: CGFloat = 3
    var outlineColor: UIColor = UIColor.white
    
    override func drawText(in rect: CGRect) {
        
        let strokeTextAttributes = [
            NSStrokeColorAttributeName: outlineColor,
            NSStrokeWidthAttributeName: -1 * outlineWidth
            ] as [String: Any]
        self.attributedText = NSAttributedString(string: self.text ?? "", attributes: strokeTextAttributes)
        super.drawText(in: rect)
    }
}
