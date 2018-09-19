//
//  AppDelegate.swift
//  PasswordView
//
//  Created by NSSimpleApps on 04.12.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let nc = UINavigationController(rootViewController: ViewController())
        nc.navigationBar.isTranslucent = false
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = nc
        self.window?.makeKeyAndVisible()
        
        return true
    }
}

