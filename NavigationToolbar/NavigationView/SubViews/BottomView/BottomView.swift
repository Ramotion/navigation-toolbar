//
//  BottomView.swift
//  NavigationToolbar
//
//  Created by obozhdi on 22/05/2018.
//  Copyright © 2018 ramotion. All rights reserved.
//

import UIKit

class BottomView: UIView {
  
  private var scrollView  : UIScrollView       = UIScrollView()
  private var controllers: [DummyController] = [DummyController(), DummyController(), DummyController()]
  private var views: [UIView] = []

  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  private func setup() {
    for contr in controllers {
      views.append(contr.view)
    }
    for view in views {
      scrollView.addSubview(view)
    }
    
    addSubview(scrollView)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    scrollView.frame       = bounds
    scrollView.contentSize = CGSize(width : CGFloat(controllers.count) * bounds.width, height : bounds.height)
    
    var i: CGFloat = 0.0
    for view in views {
      view.frame = CGRect(x: i * bounds.width, y: 0, width: bounds.width, height: bounds.height)
      i += 1.0
    }
  }

}

extension BottomView {
  
  private func setViews() {
    
  }
  
}

extension BottomView: UIScrollViewDelegate {
  
  
  
}
