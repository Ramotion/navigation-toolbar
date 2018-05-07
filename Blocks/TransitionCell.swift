//
//  Copyright © 2018 Ramotion. All rights reserved.
//

import UIKit

class TransitionCellOne: UICollectionViewCell {
  
  var imageView : UIImageView = UIImageView()
  var label     : UILabel     = UILabel()
  
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
    label.clipsToBounds = false
    label.textColor     = .white
    label.font          = UIFont.systemFont(ofSize : 23)
    label.layer.shadowColor   = UIColor.black.cgColor
    label.layer.shadowRadius  = 2.0
    label.layer.shadowOpacity = 1.0
    label.layer.shadowOffset  = CGSize(width : 2, height : 2)
    label.layer.masksToBounds = false
    
    self.addSubview(imageView)
    self.addSubview(label)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    let w = self.bounds.width
    let h = self.bounds.height
    
    label.frame     = CGRect(x: 0, y: 0, width: w, height: h)
    imageView.frame = CGRect(x : -10, y : 0, width : w + 20, height : h)
  }
  
  func setImage(title: String, image: UIImage) {
    label.text = title
//    label.text = "TOPCOL " + title + " TOPCOL"
    imageView.image = image
  }
  
}

class TransitionCellTwo: UICollectionViewCell {
  
  var imageView : UIImageView = UIImageView()
  var label     : UILabel     = UILabel()
  
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
    label.clipsToBounds = false
    label.textColor     = .white
    label.font          = UIFont.systemFont(ofSize : 23)
    label.layer.shadowColor   = UIColor.black.cgColor
    label.layer.shadowRadius  = 2.0
    label.layer.shadowOpacity = 1.0
    label.layer.shadowOffset  = CGSize(width : 2, height : 2)
    label.layer.masksToBounds = false
    
    self.addSubview(imageView)
//    self.addSubview(label)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    let w = self.bounds.width
    let h = self.bounds.height
    
    label.frame     = self.bounds
    imageView.frame = CGRect(x : -10, y : 0, width : w + 20, height : h)
  }
  
  func setImage(title: String, image: UIImage) {
    label.text = title
    imageView.image = image
  }
  
}

class TransitionCellThree: UICollectionViewCell {
  
  var imageView : UIImageView = UIImageView()
  var label     : UILabel     = UILabel()
  
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
    label.clipsToBounds = false
    label.textColor     = .white
    label.font          = UIFont.systemFont(ofSize : 23)
    label.layer.shadowColor   = UIColor.black.cgColor
    label.layer.shadowRadius  = 2.0
    label.layer.shadowOpacity = 1.0
    label.layer.shadowOffset  = CGSize(width : 2, height : 2)
    label.layer.masksToBounds = false
    
    //    self.addSubview(imageView)
    self.addSubview(label)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    let w = self.bounds.width
    let h = self.bounds.height
    
    label.frame     = self.bounds
    imageView.frame = CGRect(x : -10, y : 0, width : w + 20, height : h)
  }
  
  func setImage(title: String, image: UIImage) {
    label.text = title
//    label.text = "MIDCOLTXT " + title + " MIDCOLTXT"
//    imageView.image = image
  }
  
}
