//
//  AnimatedView.swift
//  NavigationToolbar
//
//  Created by obozhdi on 22/05/2018.
//  Copyright © 2018 ramotion. All rights reserved.
//

import UIKit

protocol CellViewDelegate: class {
  func didTapCell(index: Int, cell: CellView)
}

class CellView: UIView {
  
  private var imageView : UIImageView = UIImageView()
  private var label     : UILabel     = UILabel()
  private var view      : UIView      = UIView()
  
  private var imageLeftOffsetMax: CGFloat = 100
  private var imageLeftOffsetCurrent: CGFloat = 0
  private var tapGest: UITapGestureRecognizer = UITapGestureRecognizer()
  
  private var progress: CGFloat = 0.0
  
  weak var delegate: CellViewDelegate?
  
  var index: Int = 0
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  private func setup() {
    self.backgroundColor = .clear
    
    self.clipsToBounds = true
    
    imageView.contentMode   = .scaleAspectFill
    imageView.clipsToBounds = true
    imageView.isHidden      = false
    
    view.backgroundColor = .white
    
    label.textAlignment = .left
    label.clipsToBounds = false
    label.textColor     = .white
    label.font          = UIFont.systemFont(ofSize : 23)
//    label.layer.shadowColor   = UIColor.black.cgColor
//    label.layer.shadowRadius  = 2.0
//    label.layer.shadowOpacity = 1.0
//    label.layer.shadowOffset  = CGSize(width : 2, height : 2)
//    label.layer.masksToBounds = false
    label.isHidden = false
    
    tapGest.addTarget(self, action: #selector(tapCell))
    self.addGestureRecognizer(tapGest)
    
    self.addSubview(imageView)
    self.addSubview(label)
    self.addSubview(view)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    let w = self.bounds.width
    let h = self.bounds.height
    
    label.frame     = CGRect(x: (w / 2 - label.intrinsicContentSize.width / 2) - ((w / 2 - label.intrinsicContentSize.width / 2 - Settings.menuItemTextMargin) * progress), y: 0, width: label.intrinsicContentSize.width, height: h)
    imageView.frame = CGRect(x: -1 * Settings.imageCrossOffset + imageLeftOffsetCurrent, y: 0, width: bounds.width + 2 * Settings.imageCrossOffset, height: bounds.height)
  }
  
  @objc private func tapCell() {
    self.delegate?.didTapCell(index: index, cell: self)
  }
  
  func setData(title: String, image: UIImage, index: Int) {
    label.text = title
    imageView.image = image
    self.index = index
  }
  
  func setState(progress: CGFloat, state: State) {
    imageLeftOffsetCurrent = imageLeftOffsetMax * progress
    self.progress = progress
    
    self.setNeedsLayout()
    self.layoutIfNeeded()
  }
  
}
