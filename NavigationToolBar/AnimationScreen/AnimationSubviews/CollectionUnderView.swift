//
//  CollectionUnderView.swift
//  Animationtask
//
//  Created by obozhdi on 11/04/2018.
//  Copyright © 2018 obozhdi. All rights reserved.
//

import UIKit

class CollectionUnderView: UIView {
  let imageViewCurrent = UIImageView()
  let imageViewTemp = UIImageView()
  
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
    
    imageViewCurrent.backgroundColor = .black
    imageViewTemp.backgroundColor = .purple
    
    self.addSubview(imageViewCurrent)
    self.addSubview(imageViewTemp)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    imageViewCurrent.frame = self.bounds
    imageViewTemp.frame = self.bounds
  }
  
}
