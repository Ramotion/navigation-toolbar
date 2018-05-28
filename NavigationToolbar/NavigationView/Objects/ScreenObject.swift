//
//  ScreenObject.swift
//  NavigationToolbar
//
//  Created by obozhdi on 22/05/2018.
//  Copyright © 2018 ramotion. All rights reserved.
//

import Foundation
import UIKit

class ScreenObject {
  
  var title      : String           = "TITLE"
  var startColor : UIColor          = .red
  var endColor   : UIColor          = .blue
  var image      : UIImage          = UIImage()
  var controller : UIViewController = UIViewController()
  
  init(title: String, startColor: UIColor, endColor: UIColor, image: UIImage = UIImage(), controller: UIViewController) {
    self.title      = title
    self.startColor = startColor
    self.endColor   = endColor
    self.image      = image
    self.controller = controller
  }
  
}
