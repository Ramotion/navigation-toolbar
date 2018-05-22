//
//  UIColor+HEX.swift
//  NavigationToolbar
//
//  Created by obozhdi on 22/05/2018.
//  Copyright © 2018 ramotion. All rights reserved.
//

import UIKit

extension UIColor {
  
  convenience init(HEX: String) {
    let scanner = Scanner(string: HEX)
    scanner.scanLocation = 0
    
    var rgbValue: UInt64 = 0
    
    scanner.scanHexInt64(&rgbValue)
    
    let r = (rgbValue & 0xff0000) >> 16
    let g = (rgbValue & 0xff00) >> 8
    let b = rgbValue & 0xff
    
    self.init(
      red   : CGFloat(r) / 0xff,
      green : CGFloat(g) / 0xff,
      blue  : CGFloat(b) / 0xff, alpha  : 1
    )
  }
  
}
