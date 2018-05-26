//
//  MiddleView.swift
//  NavigationToolbar
//
//  Created by obozhdi on 22/05/2018.
//  Copyright © 2018 ramotion. All rights reserved.
//

import UIKit

class MiddleView: UIView {

  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  private func setup() {
    backgroundColor = .white
    
    layer.shadowColor   = UIColor.black.cgColor
    layer.shadowRadius  = 10.0
    layer.shadowOpacity = 0.1
    layer.shadowOffset  = CGSize(width : 0, height : 0)
    layer.masksToBounds = false
    clipsToBounds       = false
  }

}
