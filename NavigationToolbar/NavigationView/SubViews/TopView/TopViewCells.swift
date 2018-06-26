//
//  TopViewCells.swift
//  NavigationToolbar
//
//  Created by obozhdi on 22/05/2018.
//  Copyright © 2018 ramotion. All rights reserved.
//

import Foundation
import UIKit

class TopViewCellOne: UICollectionViewCell {
  
  var imageView : UIImageView = UIImageView()
  var label     : Label       = Label()
  
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
    
    label.textAlignment = .center
    
    self.addSubview(imageView)
    self.addSubview(label)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    if Settings.Sizes.isX {
      label.frame = CGRect(x: 0, y: 32, width: bounds.width, height: bounds.height - 32)
    } else {
      label.frame = CGRect(x: 0, y: 20, width: bounds.width, height: bounds.height - 20)
    }
    imageView.frame = CGRect(x: -1 * Settings.imageCrossOffset, y: 0, width: bounds.width + 2 * Settings.imageCrossOffset, height: bounds.height)
  }
  
  func setData(title: String, image: UIImage) {
    label.text = title
    imageView.image = image
  }
  
}

class TopViewCellTwo: UICollectionViewCell {
  
  var imageView : UIImageView = UIImageView()
  
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
    
    self.addSubview(imageView)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    imageView.frame = CGRect(x: -1 * Settings.imageCrossOffset, y: 0, width: bounds.width + 2 * Settings.imageCrossOffset, height: bounds.height)
  }
  
  func setImage(image: UIImage) {
    imageView.image = image
  }
  
}

class TopViewCellThree: UICollectionViewCell {
  
  var label : Label = Label()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  private func setup() {
    label.textAlignment = .center
    self.addSubview(label)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    label.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
  }
  
  func setTitle(title: String) {
    label.text = title
  }
  
}
