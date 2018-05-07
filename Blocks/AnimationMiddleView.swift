//
//  Copyright © 2018 Ramotion. All rights reserved.
//

import UIKit

class AnimationMiddleView: UIView {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    configure()
  }
  
  private func configure() {
    self.backgroundColor = .gray
  }
  
}
