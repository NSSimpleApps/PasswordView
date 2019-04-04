//
//  ViewController.swift
//  PasswordView
//
//  Created by NSSimpleApps on 04.12.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = .all
        self.extendedLayoutIncludesOpaqueBars = false
        self.title = "Password View"
        self.view.backgroundColor = UIColor.white
        
        let passwordView = PasswordView(frame: CGRect(center: self.view.center, size: 100), passwordLength: 4)
        passwordView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(passwordView)
        
        let top = NSLayoutConstraint(item: passwordView,
                                     attribute: .top,
                                     relatedBy: .equal,
                                     toItem: self.view.safeAreaLayoutGuide,
                                     attribute: .top,
                                     multiplier: 1,
                                     constant: 8)
        let left = NSLayoutConstraint(item: self.view!,
                                      attribute: .leadingMargin,
                                      relatedBy: .equal,
                                      toItem: passwordView,
                                      attribute: .leading,
                                      multiplier: 1,
                                      constant: 0)
        let right = NSLayoutConstraint(item: self.view!,
                                       attribute: .trailingMargin,
                                       relatedBy: .equal,
                                       toItem: passwordView,
                                       attribute: .trailing,
                                       multiplier: 1,
                                       constant: 0)
        let height = NSLayoutConstraint(item: passwordView,
                                       attribute: .height,
                                       relatedBy: .equal,
                                       toItem: nil,
                                       attribute: .notAnAttribute,
                                       multiplier: 1,
                                       constant: 120)
        
        NSLayoutConstraint.activate([top, left, right, height])
        
        passwordView.delegate = self
        passwordView.becomeFirstResponder()
    }
}

extension ViewController: PasswordViewDelegate {
    func enterPasswordDidFinish(_ passwordView: PasswordView) {
        if passwordView.text == "1234" {
            passwordView.tintColor = PasswordView.greenColor
            
        } else {
            passwordView.tintColor = PasswordView.redColor
        }
        
        passwordView.shake {
            passwordView.removeText()
            passwordView.tintColor = PasswordView.blueColor
        }
    }
}
