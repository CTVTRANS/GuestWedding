//
//  SetupProfile.swift
//  GuestWedding
//
//  Created by Kien on 11/2/17.
//  Copyright © 2017 Kien. All rights reserved.
//

import UIKit
import SDWebImage

class SetupProfile: BaseDailog, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var heightOfAvatar: NSLayoutConstraint!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UITextField!
    
    var callBack = {}
    var changeProfile:((_ name: String) -> Void) = {_ in}
    
    private let picker = UIImagePickerController()

    override func awakeFromNib() {
        avatar.layer.cornerRadius = heightOfAvatar.constant / 2
        picker.delegate = self
        avatar.sd_setImage(with: URL(string: Guest.shared.avatar))
    }
    
    @IBAction func pressedSendChange(_ sender: Any) {
        changeProfile(name.text!)
    }
    
    @IBAction func pressedUpdateAvatar(_ sender: Any) {
       self.callBack()
    }
}
