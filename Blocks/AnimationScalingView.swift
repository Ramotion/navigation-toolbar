//
//  Copyright © 2018 Ramotion. All rights reserved.
//

import UIKit

class AnimationScalingView: UIView {

  private var cellImageView: UIImageView = UIImageView()
  private var celLabel: UILabel = UILabel()
  
  private var leftLabel: UILabel = UILabel()
  private var rightLabel: UILabel = UILabel()
  
  var progress: CGFloat = 0 {
    didSet {
      UIView.animate(withDuration: 0.15) {
        self.setNeedsLayout()
        self.layoutIfNeeded()
      }
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
    celLabel.textAlignment = .center
    celLabel.clipsToBounds = false
    celLabel.textColor     = .white
    celLabel.font          = UIFont.systemFont(ofSize : 23)
    celLabel.layer.shadowColor   = UIColor.black.cgColor
    celLabel.layer.shadowRadius  = 2.0
    celLabel.layer.shadowOpacity = 1.0
    celLabel.layer.shadowOffset  = CGSize(width : 2, height : 2)
    celLabel.layer.masksToBounds = false
    
    leftLabel.textAlignment = .center
    leftLabel.clipsToBounds = false
    leftLabel.textColor     = .white
    leftLabel.font          = UIFont.systemFont(ofSize : 20.75)
    leftLabel.layer.shadowColor   = UIColor.black.cgColor
    leftLabel.layer.shadowRadius  = 2.0
    leftLabel.layer.shadowOpacity = 1.0
    leftLabel.layer.shadowOffset  = CGSize(width : 2, height : 2)
    leftLabel.layer.masksToBounds = false
    leftLabel.text = "MOOD"
    leftLabel.alpha = 0.5
    
    rightLabel.textAlignment = .center
    rightLabel.clipsToBounds = false
    rightLabel.textColor     = .white
    rightLabel.font          = UIFont.systemFont(ofSize : 20.75)
    rightLabel.layer.shadowColor   = UIColor.black.cgColor
    rightLabel.layer.shadowRadius  = 2.0
    rightLabel.layer.shadowOpacity = 1.0
    rightLabel.layer.shadowOffset  = CGSize(width : 2, height : 2)
    rightLabel.layer.masksToBounds = false
    rightLabel.text = "GAMING"
    rightLabel.alpha = 0.5
    
    cellImageView.contentMode = .scaleAspectFill
    cellImageView.clipsToBounds = true
    
    addSubview(cellImageView)
    addSubview(celLabel)
    addSubview(leftLabel)
    addSubview(rightLabel)
  }
  
  func setData(title: String, image: UIImage, left: String, right: String) {
    celLabel.text       = title
//    celLabel.text       = "SCALV " + title + " SCALV"
    cellImageView.image = image
    leftLabel.text      = left
    rightLabel.text     = right
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    cellImageView.frame = CGRect(x: -10, y: 0, width: bounds.width + 20, height: bounds.height)
    celLabel.frame      = bounds
    
    let w = bounds.width
    let half = bounds.width / 2
    
    leftLabel.frame = CGRect(x: -1 * w * 0.21 - 200.0 * (1.0 - progress), y: 0, width: bounds.width / 2, height: bounds.height)
    rightLabel.frame = CGRect(x: half + w * 0.21 + 200.0 * (1.0 - progress), y: 0, width: bounds.width / 2, height: bounds.height)
  }
}
