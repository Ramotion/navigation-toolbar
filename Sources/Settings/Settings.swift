//
//  Settings.swift
//  NavigationToolbar
//
//  Created by Artem P. on 22/05/2018.
//  Copyright © 2018 Ramotion. All rights reserved.
//

import Foundation
import UIKit

public struct Settings {
    
    public struct Sizes {
        public static let isX: Bool = UIScreen.main.nativeBounds.height == 2436 ? true : false
        public static let statusbarSize: CGFloat = UIApplication.shared.statusBarFrame.height
        public static let navbarSize: CGFloat = isX ? 88 : 64
        public static let middleSize: CGFloat = Settings.Sizes.screenHeight / 2 - middleViewSize / 2
        public static let middleSizeHalf: CGFloat = (Settings.Sizes.screenHeight / 2 - middleViewSize / 2) / 2
        public static let fullSize: CGFloat = Settings.Sizes.screenHeight
        public static let middleViewSize: CGFloat = 65.5
        public static let menuItemsSize: CGFloat = 120.0
        public static let screenWidth = UIScreen.main.bounds.width
        public static let screenHeight = UIScreen.main.bounds.height
        public static let labelFontSize: CGFloat = 23
        public static let yOffset: CGFloat = isX ? 32 : 20
        public static let mainOffset: CGFloat = 200
    }
    
    public static var animationsDuration: TimeInterval = 0.35
    public static var imageCrossOffset: CGFloat = 20
    public static var imageAlpha: CGFloat = 0.33
    public static var menuItemsSpacing: CGFloat = 4
    public static var menuItemTextMargin: CGFloat = 40
    
}
