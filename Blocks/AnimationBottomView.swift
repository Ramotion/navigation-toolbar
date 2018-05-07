//
//  Copyright © 2018 Ramotion. All rights reserved.
//

import UIKit

class AnimationBottomView: UIView {
  
  var scrollView: UIScrollView = UIScrollView()
  
  private var controllers : [ScreenObject] = []
  private var views       : [UIView]           = []
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    configure()
  }
  
  private func configure() {
    self.backgroundColor = .white
    
    scrollView.bounces = false
    scrollView.isPagingEnabled = true
    
    self.addSubview(scrollView)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    let w = self.bounds.width
    let h = self.bounds.height
    
    scrollView.frame = self.bounds
    
    var counter = 0
    for view in views {
      view.frame = CGRect(x: w * CGFloat(counter), y: 0, width: w, height: h)
      counter += 1
    }
    
    scrollView.contentSize = CGSize(width: w * CGFloat(views.count), height: h)
  }
  
  func setScreens(screens: [ScreenObject]) {
    for screen in screens {
      views.append(screen.controller.view)
    }
    for view in views {
      scrollView.addSubview(view)
    }
    self.setNeedsLayout()
    self.layoutIfNeeded()
  }
  
  func setActiveView(index: Int) {
    scrollView.contentOffset.x = self.bounds.width * CGFloat(index)
  }
  
}
