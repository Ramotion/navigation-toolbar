//
//  MiddleView.swift
//  NavigationToolbar
//
//  Created by obozhdi on 22/05/2018.
//  Copyright © 2018 ramotion. All rights reserved.
//

import UIKit

class MiddleView: UIView {
  
  private var separatorView : UIView   = UIView()
  private var leftButton    : UIButton = UIButton()
  private var rightButton   : UIButton = UIButton()

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
    
    separatorView.backgroundColor = .lightGray
    
    leftButton.setTitle("Left", for: .normal)
    rightButton.setTitle("Right", for: .normal)
    
    leftButton.setTitleColor(.gray, for: .normal)
    rightButton.setTitleColor(.gray, for: .normal)
    
    self.addSubview(separatorView)
    self.addSubview(leftButton)
    self.addSubview(rightButton)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    let w = bounds.width
    let h = bounds.height
    
    separatorView.frame = CGRect(x: w / 2 - 0.5, y: 14, width: 1, height: h - 28)
    leftButton.frame = CGRect(x: w / 2 - 100, y: 0, width: 90, height: h)
    rightButton.frame = CGRect(x: separatorView.frame.maxX + CGFloat(9.5), y: 0, width: 90, height: h)
  }

}
