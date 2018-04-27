//
//  Settings.swift
//  Blocks
//
//  Created by obozhdi on 26/04/2018.
//  Copyright © 2018 obozhdi. All rights reserved.
//

import Foundation
import UIKit

public struct Layout {
  struct TopView {
    static let topSize     : CGFloat = 64
    static let midSize     : CGFloat = UIScreen.main.bounds.height / 2 - 37.5
    static let botSize     : CGFloat = 120
    static let botInterval : CGFloat = 4
  }
  struct MidView {
    static let height : CGFloat = 65
  }
  
  struct BotView {
    static let heightTop : CGFloat = UIScreen.main.bounds.height - Layout.TopView.topSize
    static let heightMid : CGFloat = UIScreen.main.bounds.height - Layout.TopView.midSize
    static let heightBot : CGFloat = UIScreen.main.bounds.height - Layout.TopView.midSize
  }
}
