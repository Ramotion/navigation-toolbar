//
//  Copyright © 2018 Ramotion. All rights reserved.
//

import UIKit

protocol CellViewDelegate {
  func didTapCell(index: Int)
}

class CellView: UIView {
  
  private var imageView : UIImageView = UIImageView()
  private var label     : UILabel     = UILabel()
  private var view      : UIView      = UIView()
  
  private var imageLeftOffset: CGFloat = 0
  private var tapGest: UITapGestureRecognizer = UITapGestureRecognizer()
  
  var animator: UIViewPropertyAnimator!
  
  var delegate: CellViewDelegate?
  
  var index     : Int  = 0
  private var prevState : State = .top
  private var state     : State = .top {
    didSet {
      prevState = oldValue
      if prevState == .top || prevState == .mid {
        switch state {
        case .top:
          imageView.isHidden = true
        case .mid:
          imageView.isHidden = true
        case .bot:
          imageView.isHidden = false
        }
      }
      
      UIView.animate(withDuration: 0.99, animations: {
        self.setNeedsLayout()
        self.layoutIfNeeded()
      }) { (completed) in
        if self.prevState == .bot {
          switch self.state {
          case .top:
            self.imageView.isHidden = true
          case .mid:
            self.imageView.isHidden = true
          case .bot:
            self.imageView.isHidden = false
          }
        }
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
    self.backgroundColor = .clear
    
    animator = UIViewPropertyAnimator(duration: 2, curve: .easeInOut) { [unowned self, imageView] in
      imageView.center.x  = self.bounds.width / 2
      imageView.transform = CGAffineTransform(translationX : 2.5, y : 0)
    }
    
    imageView.contentMode   = .scaleAspectFill
    imageView.clipsToBounds = true
    imageView.isHidden      = true
    
    view.backgroundColor = .white
    
    label.textAlignment = .left
    label.clipsToBounds = false
    label.textColor     = .white
    label.font          = UIFont.systemFont(ofSize : 23)
    
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
    imageView.frame = CGRect(x : imageLeftOffset, y : 0, width : w, height : h)
    
    switch state {
    case .top:
      view.frame = CGRect(x: w / 2 - 30, y: h - 10, width: 60, height: 3)
    case .mid:
      view.frame = CGRect(x: w / 2 - 30, y: h - 20, width: 60, height: 3)
    case .bot:
      view.frame = CGRect(x: w - 70, y: h - 20, width: 70, height: 3)
    }
  }
  
  @objc private func tapCell() {
    self.delegate?.didTapCell(index: index)
  }
  
  func setData(data: (text: String, image: UIImage), index: Int) {
    let gradient    : UIImage = UIImage.imageWithGradient(from    : UIColor.red, to    : UIColor.blue)
    let mergedImage : UIImage = UIImage.mergeImages(bottom : gradient, top : data.image)
    imageView.image           = mergedImage
    self.index = index
    
    label.text = data.text.uppercased()
  }
  
  func setState(state: State) {
    switch state {
    case .top:
      imageLeftOffset = 0
    case .mid:
      imageLeftOffset = 0
    case .bot:
      imageLeftOffset = 100
    }
    
    self.state = state
  }
  
  func setTransparency(transparency: CGFloat) {
    animator.fractionComplete = transparency
  }
  

}
