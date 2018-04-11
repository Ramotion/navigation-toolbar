import Foundation
import UIKit

struct AnimationViewSettings {
  struct Layout {
    static let midViewHeight: CGFloat = 65
    
    static let cellHeightNavbarMode:     CGFloat = 64
    static let cellHeightHalfScreenMode: CGFloat = UIScreen.main.bounds.size.height / 2 - AnimationViewSettings.Layout.midViewHeight / 2
    static let cellHeightMenuMode:       CGFloat = 120
    static let cellSpacingMenuMode:      CGFloat = 4
  }
}
