//
//  SizingView.swift
//  NavigationToolbar
//
//  Created by obozhdi on 22/05/2018.
//  Copyright © 2018 ramotion. All rights reserved.
//

import UIKit

class SizingView: UIView {
  
  private var imageView : UIImageView = UIImageView()
  private var label      : Label = Label()
  private var leftLabel  : Label = Label()
  private var rightLabel : Label = Label()
  
  var progress: CGFloat = 0 {
    didSet {
      self.setNeedsLayout()
      self.layoutIfNeeded()
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  private func setup() {
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    imageView.image = UIImage(named: "image1")
    
    label.textAlignment      = .center
    leftLabel.textAlignment  = .center
    rightLabel.textAlignment = .center
    leftLabel.font           = UIFont.systemFont(ofSize : 23)
    rightLabel.font          = UIFont.systemFont(ofSize : 23)
    leftLabel.alpha          = 1.0
    rightLabel.alpha         = 1.0
    
    addSubview(imageView)
    addSubview(label)
    addSubview(leftLabel)
    addSubview(rightLabel)
  }
  
  func setData(title: String, image: UIImage, previousTitle: String, nextTitle: String) {
    label.text      = title
    imageView.image = image
    leftLabel.text      = previousTitle
    rightLabel.text     = nextTitle
  }
  
  func animateCollapse() {
    UIView.animate(withDuration: Settings.animationsDuration, animations: {
      
      self.leftLabel.frame = CGRect(x: -1 * self.bounds.width * 0.21 - 200.0 * (1.0), y: 0, width: self.bounds.width / 2, height: self.bounds.height)
      self.rightLabel.frame = CGRect(x: self.bounds.width / 2 + self.bounds.width * 0.21 + 200.0 * (1.0), y: 0, width: self.bounds.width / 2, height: self.bounds.height)
      self.bounds = CGRect(x: 0, y: 0, width: self.bounds.width, height: Settings.Sizes.navbarSize)
      
      self.setNeedsLayout()
      self.layoutIfNeeded()
    }) { (completed) in
      
    }
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    imageView.frame = CGRect(x: -1 * Settings.imageCrossOffset, y: 0, width: bounds.width + 2 * Settings.imageCrossOffset, height: bounds.height)
    
    var offsetR: CGFloat = 165
    var offsetL: CGFloat = 166
    
    switch UIScreen.main.bounds.width {
    case 320:
      offsetR = 192
      offsetL = 193
      break
    case 375:
      offsetR = 226
      offsetL = 227
    case 414:
      offsetR = 249
      offsetL = 250
      break
    default:
      break
    }
    
    if Settings.Sizes.isX {
      label.frame      = CGRect(x: 0,                                y: 32 - 32 * progress, width: bounds.width, height: bounds.height - 32 + 32 * progress)
      rightLabel.frame = CGRect(x: offsetR + (200 - 200 * progress), y: 32 - 32 * progress, width: bounds.width, height: bounds.height - 32 + 32 * progress)
      leftLabel.frame  = CGRect(x: -1 * offsetL - (200 - 200 * progress),                     y: 32 - 32 * progress, width: bounds.width, height: bounds.height - 32 + 32 * progress)
    } else {
      label.frame      = CGRect(x: 0,                                y: 20 - 20 * progress, width: bounds.width, height: bounds.height - 20 + 20 * progress)
      rightLabel.frame = CGRect(x: offsetR + (200 - 200 * progress), y: 20 - 20 * progress, width: bounds.width, height: bounds.height - 20 + 20 * progress)
      leftLabel.frame  = CGRect(x: -1 * offsetL - (200 - 200 * progress),                     y: 20 - 20 * progress, width: bounds.width, height: bounds.height - 20 + 20 * progress)
    }
    
//    leftLabel.alpha  = 0.5 * progress
//    rightLabel.alpha = 0.5 * progress
    
    leftLabel.alpha  = 0.3
    rightLabel.alpha = 0.3
    
    
    
//    leftLabel.frame = CGRect(x: -1 * bounds.width * 0.21 - offset * (1.0 - progress), y: 0, width: bounds.width / 2, height: bounds.height)
//    rightLabel.frame = CGRect(x: 270, y: 0, width: bounds.width / 2, height: bounds.height)
  }
}
