//
//  BaseViewController.swift
//  GuestWedding
//
//  Created by Kien on 10/31/17.
//  Copyright © 2017 Kien. All rights reserved.
//

import UIKit
import SWRevealViewController
import DeviceKit

class BaseViewController: UIViewController {

    var swVC: SWRevealViewController?
    var activity: UIActivityIndicatorView?
    var backGroundview: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        swVC = self.revealViewController()
    }
    
    func setupNavigation() {
        if self.revealViewController() != nil {
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_leftButton"), style: .plain, target: self.revealViewController(), action: #selector(revealViewController().revealToggle(_:)))
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_back"), style: .done, target: self, action: #selector(popToRootNavigation))
            navigationItem.title = "婚禮籌備平台"
            //            self.navigationController?.navigationBar.isTranslucent = false
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        }
    }
    
    func popToRootNavigation() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainView") as? MainViewController
        let navigationController: UINavigationController = UINavigationController.init(rootViewController: vc!)
        swVC?.pushFrontViewController(navigationController, animated: true)
        
    }
    
    
    func showActivity(inView myView: UIView) {
        //        backGroundview = UIView(frame: UIScreen.main.bounds)
        backGroundview = UIView(frame: myView.bounds)
        backGroundview?.backgroundColor = UIColor.white
        let loadingView = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        loadingView.backgroundColor = UIColor.clear
        activity = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        loadingView.addSubview(activity!)
        let nameLoading = UILabel(frame: CGRect(x: 0, y: 0, width: 80, height: 20))
        nameLoading.font = UIFont(name: "Helvetica Neue", size: 15)
        nameLoading.text = "loading..."
        nameLoading.textAlignment = .center
        nameLoading.textColor = UIColor.gray
        nameLoading.backgroundColor = UIColor.clear
        nameLoading.translatesAutoresizingMaskIntoConstraints = true
        loadingView.addSubview(nameLoading)
        
        backGroundview?.addSubview(loadingView)
        nameLoading.center = CGPoint(x: loadingView.center.x, y: loadingView.center.y + 23)
        activity?.center = loadingView.center
        loadingView.center = (backGroundview?.center)!
        myView.addSubview(backGroundview!)
        //        UIApplication.shared.keyWindow?.addSubview(backGroundview!)
        activity?.startAnimating()
    }
    
    func stopActivityIndicator() {
        activity?.stopAnimating()
        backGroundview?.removeFromSuperview()
    }
}

extension UIColor {
    static func rgb(_ red: Float, _ blue: Float, _ green: Float) -> UIColor {
        return UIColor(colorLiteralRed: red/255.0, green: blue/255.0, blue: green/255.0, alpha: 1.0)
    }
}

extension UILabel {
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
