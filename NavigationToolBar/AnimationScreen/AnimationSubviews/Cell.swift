import UIKit

class Cell: UICollectionViewCell {
  
  var cellLabel = UILabel()
  var imageView = UIImageView()
  var imageViewBottom = UIImageView()
  
  var state: Int = 0
  
  var left: CGFloat {
    get {
      switch state {
      case 0:
        return 0
      case 1:
        return 0
      case 2:
        return 85
      default:
        return 0
      }
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    configure()
  }
  
  private func configure() {
    self.backgroundColor  = .clear
    
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    imageView.backgroundColor = .clear
    
    cellLabel.frame = self.bounds
    cellLabel.textColor = .white
    if state == 0 || state == 1 {
      cellLabel.textAlignment = .center
    } else {
      cellLabel.textAlignment = .left
    }
    
    imageView.frame = self.bounds
    
//    self.addSubview(imageView)
    self.addSubview(cellLabel)
    
    self.setNeedsLayout()
    self.layoutIfNeeded()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    let w = self.bounds.size.width
    let h = self.bounds.size.height
    
    if state == 0 || state == 1 {
      cellLabel.frame = self.bounds
    } else {
      cellLabel.frame = CGRect(x: 47, y: 0, width: w - 47, height: h)
    }
    
//    imageView.frame = CGRect(x: left, y: 0, width: w - left, height: h)
  }
  
  func setData(title: String, image: UIImage) {
    let bottomImage = UIImage.imageWithGradient(from: .red, to: .blue)
    imageView.image = UIImage.mergeImages(bottom: bottomImage, top: image)

    cellLabel.text  = "INDEXPATH: \(title)"
  }
  
  func setState(state: Int) {
    self.state = state
    let w = self.bounds.size.width
    let h = self.bounds.size.height
    
    UIView.animate(withDuration: 0.25) {
      if state == 0 || state == 1 {
        self.cellLabel.frame = self.bounds
        self.cellLabel.textAlignment = .center
      } else {
        self.cellLabel.frame = CGRect(x: 47, y: 0, width: w - 47, height: h)
        self.cellLabel.textAlignment = .left
      }
      self.imageView.frame = CGRect(x: self.left, y: 0, width: self.bounds.size.width - self.left, height: self.bounds.size.height)

      self.setNeedsLayout()
      self.layoutIfNeeded()
    }
    
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    self.setNeedsLayout()
    self.layoutIfNeeded()
  }
    
}

