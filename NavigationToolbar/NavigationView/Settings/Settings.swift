//
//  Settings.swift
//  NavigationToolbar
//
//  Created by obozhdi on 22/05/2018.
//  Copyright © 2018 ramotion. All rights reserved.
//

import Foundation
import UIKit

struct Settings {
  
  struct Sizes {
    static let isX            : Bool    = UIScreen.main.nativeBounds.height == 2436 ? true : false
    static let statusbarSize  : CGFloat = UIApplication.shared.statusBarFrame.height
    static let navbarSize     : CGFloat = isX ? 88 : 64
    static let middleSize     : CGFloat = UIScreen.main.bounds.height / 2 - middleViewSize / 2
    static let fullSize       : CGFloat = UIScreen.main.bounds.height
    static let middleViewSize : CGFloat = 65.5
    static let menuItemsSize  : CGFloat = 120.0
  }
  
  static var animationsDuration : TimeInterval = 0.35
  static var imageCrossOffset   : CGFloat      = 20
  static var imageAlpha         : CGFloat      = 0.33
  static var menuItemsSpacing   : CGFloat      = 4
  static var menuItemTextMargin : CGFloat      = 40
  
}
