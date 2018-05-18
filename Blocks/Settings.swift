//
//  Copyright © 2018 Ramotion. All rights reserved.
//


import Foundation
import UIKit

public struct Layout {
  
  struct TopView {
    static let topStateSize        : CGFloat = 64.0
    static let middleStateSize     : CGFloat = UIScreen.main.bounds.height / 2 - MidView.height / 2
    static let bottomStateSize     : CGFloat = 120.0
    static let bottomStateInterval : CGFloat = 4.0
  }
  
  struct MidView {
    static let height : CGFloat = 65.5
    static let half   : CGFloat = height / 2
  }
  
}
