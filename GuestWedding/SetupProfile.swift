//
//  SetupProfile.swift
//  GuestWedding
//
//  Created by Kien on 11/2/17.
//  Copyright © 2017 Kien. All rights reserved.
//

import UIKit

class SetupProfile: BaseDailog {

    @IBOutlet weak var heightOfAvatar: NSLayoutConstraint!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var nameTextField: UIView!

    override func awakeFromNib() {
        avatar.layer.cornerRadius = heightOfAvatar.constant / 2
    }
    
    @IBAction func pressedUpdateAvatar(_ sender: Any) {
        
    }
}
