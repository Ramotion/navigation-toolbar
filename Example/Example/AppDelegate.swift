//
//  AppDelegate.swift
//  NavigationToolbar
//
//  Created by Artem P. on 21/05/2018.
//  Copyright © 2018 Ramotion. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()
        
        return true
    }
}
