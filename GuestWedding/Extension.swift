//
//  Extension.swift
//  GuestWedding
//
//  Created by Kien on 11/1/17.
//  Copyright © 2017 Kien. All rights reserved.
//

import UIKit
import DeviceKit

class Extension: NSObject {

}

extension UIAlertController {
    
    static func showAlertWith(title: String, message: String, in viewController: UIViewController) {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        viewController.present(alert, animated: true, completion: nil)
    }
    
    static func showAlertWith(title: String, message: String, in viewController: UIViewController, compeletionHandler: @escaping () -> Void) {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let accept = UIAlertAction(title: "OK", style: .default) { (_) in
            compeletionHandler()
        }
        alert.addAction(cancel)
        alert.addAction(accept)
        viewController.present(alert, animated: true, completion: nil)
    }
    
    static func showActionSheet(listTitle: [String], in viewController: UIViewController, compeletionHandler: @escaping (Int) -> Void ) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        for index in 0..<listTitle.count {
            let action = UIAlertAction(title: listTitle[index], style: .default, handler: { (_) in
                compeletionHandler(index)
            })
            alert.addAction(action)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancel)
        viewController.present(alert, animated: true, completion: nil)
    }
}

extension UIColor {
    static func rgb(_ red: CGFloat, _ blue: CGFloat, _ green: CGFloat) -> UIColor {
        return UIColor(red: red/255.0, green: blue/255.0, blue: green/255.0, alpha: 1.0)
    }
}

extension UITextView {
    @IBInspectable
    var adjustFontToRealIPhoneSize: Bool {
        set {
            if newValue {
                let currentFont = self.font
                var sizeScale: CGFloat = 1
                let device = Device()
                if device == .simulator(.iPhone7) || device == .simulator(.iPhone6) || device == .iPhone6
                    || device == .iPhone6s || device == .iPhone7 || device == .simulator(.iPhone8)
                    || device == .iPhone8 {
                    sizeScale = 1.2
                } else if device == .simulator(.iPhone6Plus) || device == .simulator(.iPhone7Plus)
                    || device == .iPhone6Plus || device == .iPhone7Plus || device == .simulator(.iPhone8Plus)
                    || device == .iPhone8Plus {
                    sizeScale = 1.3
                }
                self.font = currentFont?.withSize((currentFont?.pointSize)! * sizeScale)
            }
        }
        get {
            return false
        }
    }
}

extension UILabel {
    @IBInspectable
    var adjustFontToRealIPhoneSize: Bool {
        set {
            if newValue {
                let currentFont = self.font
                var sizeScale: CGFloat = 1
                let device = Device()
                if device == .simulator(.iPhone7) || device == .simulator(.iPhone6) || device == .iPhone6
                    || device == .iPhone6s || device == .iPhone7 || device == .simulator(.iPhone8)
                    || device == .iPhone8 {
                    sizeScale = 1.2
                } else if device == .simulator(.iPhone6Plus) || device == .simulator(.iPhone7Plus)
                    || device == .iPhone6Plus || device == .iPhone7Plus || device == .simulator(.iPhone8Plus)
                    || device == .iPhone8Plus {
                    sizeScale = 1.3
                }
                self.font = currentFont?.withSize((currentFont?.pointSize)! * sizeScale)
            }
        }
        get {
            return false
        }
    }
}

extension UITextField {
    @IBInspectable
    var adjustFontToRealIPhoneSize: Bool {
        set {
            if newValue {
                let currentFont = self.font
                var sizeScale: CGFloat = 1
                let device = Device()
                if device == .simulator(.iPhone7) || device == .simulator(.iPhone6) || device == .iPhone6
                    || device == .iPhone6s || device == .iPhone7 || device == .simulator(.iPhone8)
                    || device == .iPhone8 {
                    sizeScale = 1.2
                } else if device == .simulator(.iPhone6Plus) || device == .simulator(.iPhone7Plus)
                    || device == .iPhone6Plus || device == .iPhone7Plus || device == .simulator(.iPhone8Plus)
                    || device == .iPhone8Plus {
                    sizeScale = 1.3
                }
                self.font = currentFont?.withSize((currentFont?.pointSize)! * sizeScale)
            }
        }
        get {
            return false
        }
    }
}

extension NSLayoutConstraint {
    @IBInspectable
    var adjustConstantToRealIPhoneSize: Bool {
        set {
            if newValue {
                let currentConstant = self.constant
                var sizeScale: CGFloat = 1
                let device = Device()
                if device == .simulator(.iPhone7) || device == .simulator(.iPhone6) || device == .iPhone6
                    || device == .iPhone6s || device == .iPhone7 || device == .simulator(.iPhone8)
                    || device == .iPhone8 {
                    sizeScale = 1.2
                } else if device == .simulator(.iPhone6Plus) || device == .simulator(.iPhone7Plus)
                    || device == .iPhone6Plus || device == .iPhone7Plus || device == .simulator(.iPhone8Plus)
                    || device == .iPhone8Plus {
                    sizeScale = 1.3
                }
                self.constant = currentConstant * sizeScale
            }
        }
        get {
            return false
        }
    }
}

extension UIButton {
    @IBInspectable
    var adjustFontToRealIPhoneSize: Bool {
        set {
            if newValue {
                let currentFont = self.titleLabel?.font
                var sizeScale: CGFloat = 1
                //                let model = UIDevice.current.model
                let device = Device()
                if device == .simulator(.iPhone7) || device == .simulator(.iPhone6)  || device == .iPhone6s
                    || device == .iPhone6 || device == .iPhone7 || device == .simulator(.iPhone8)
                    || device == .iPhone8 {
                    sizeScale = 1.2
                } else if device == .simulator(.iPhone6Plus) || device == .simulator(.iPhone7Plus)
                    || device == .iPhone6Plus || device == .iPhone7Plus || device == .simulator(.iPhone8Plus)
                    || device == .iPhone8Plus {
                    sizeScale = 1.3
                }
                //                if model == "iPhone 6" {
                //                    sizeScale = 1.3
                //                }
                //                else if model == "iPhone 6 Plus" {
                //                    sizeScale = 1.5
                //                }
                self.titleLabel?.font = currentFont?.withSize((currentFont?.pointSize)! * sizeScale)
            }
        }
        
        get {
            return false
        }
    }
}
