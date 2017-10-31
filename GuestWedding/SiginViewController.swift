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

    @IBAction func pressedSigin(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "SWRevealViewController") as? SWRevealViewController {
            self.present(vc, animated: false, completion: nil)
        }
    }
}
