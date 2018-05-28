//
//  Label.swift
//  NavigationToolbar
//
//  Created by obozhdi on 22/05/2018.
//  Copyright © 2018 ramotion. All rights reserved.
//

import UIKit

class Label: UILabel {

  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  private func setup() {
    clipsToBounds       = false
    textColor           = .white
    font                = UIFont.systemFont(ofSize : 23)
    layer.shadowColor   = UIColor.black.cgColor
    layer.shadowRadius  = 2.0
    layer.shadowOpacity = 1.0
    layer.shadowOffset  = CGSize(width : 2, height : 2)
    layer.masksToBounds = false
  }

}
