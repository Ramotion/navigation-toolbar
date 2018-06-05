//
//  AppDelegate.swift
//  NavigationToolbar
//
//  Created by obozhdi on 21/05/2018.
//  Copyright © 2018 ramotion. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    #if DEBUG
    Bundle(path: "/Applications/InjectionIII.app/Contents/Resources/iOSInjection.bundle")?.load()
    #endif
    
    return true
  }
  
}
