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
      print(progress)
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
    leftLabel.font           = UIFont.systemFont(ofSize : 20.75)
    rightLabel.font          = UIFont.systemFont(ofSize : 20.75)
    leftLabel.alpha          = 0.5
    rightLabel.alpha         = 0.5
    
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
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    imageView.frame = CGRect(x: -1 * Settings.imageCrossOffset, y: 0, width: bounds.width + 2 * Settings.imageCrossOffset, height: bounds.height)
    
    if Settings.Sizes.isX {
      label.frame = CGRect(x: 0, y: 32 - 32 * progress, width: bounds.width, height: bounds.height - 32 + 32 * progress)
    } else {
      label.frame = CGRect(x: 0, y: 20 - 20 * progress, width: bounds.width, height: bounds.height - 20 + 20 * progress)
    }
    
    let half = bounds.width / 2
    
    leftLabel.frame = CGRect(x: -1 * bounds.width * 0.21 - 200.0 * (1.0 - progress), y: 0, width: bounds.width / 2, height: bounds.height)
    rightLabel.frame = CGRect(x: half + bounds.width * 0.21 + 200.0 * (1.0 - progress), y: 0, width: bounds.width / 2, height: bounds.height)
  }
}
