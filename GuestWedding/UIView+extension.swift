//
//  UIView+extension.swift
//  GuestWedding
//
//  Created by le kien on 1/3/18.
//  Copyright © 2018 Kien. All rights reserved.
//

import UIKit

extension UIView {
    
    // MARK: Change borderWith
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    // MARK: Change borderColor
    @IBInspectable
    var borderColor: UIColor {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
    
    // MARK: Change Number ConerRadius
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}
