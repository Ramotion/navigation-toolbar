//
//  Copyright © 2018 Ramotion. All rights reserved.
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
    label.layer.shadowColor   = UIColor.black.cgColor
    label.layer.shadowRadius  = 2.0
    label.layer.shadowOpacity = 1.0
    label.layer.shadowOffset  = CGSize(width : 2, height : 2)
    label.layer.masksToBounds = false
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
    
    label.frame     = CGRect(x: w / 2 - label.intrinsicContentSize.width / 2, y: 0, width: label.intrinsicContentSize.width, height: h)
    imageView.frame = CGRect(x : -10 + imageLeftOffsetCurrent, y : 0, width : w + 20, height : h)
  }
  
  @objc private func tapCell() {
    self.delegate?.didTapCell(index: index, cell: self)
  }
  
  func setData(data: (text: String, image: UIImage), index: Int) {
    imageView.image = data.image
    self.index = index
    
    label.text = data.text.uppercased()
//    label.text = "CELLV " + data.text.uppercased() + " CELLV"
  }
  
  func setState(progress: CGFloat, state: State) {
//    if state == .horizontal {
//      imageView.isHidden = true
//      label.isHidden     = true
//    } else {
//      imageView.isHidden = false
//      label.isHidden     = false
//    }
    imageLeftOffsetCurrent = imageLeftOffsetMax * progress
    
    self.setNeedsLayout()
    self.layoutIfNeeded()
  }

}
