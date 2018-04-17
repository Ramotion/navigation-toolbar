import UIKit

class CollectionUnderView: UIView {
  let imageViewCurrent = UIImageView()
  
  var imageViews: [UIImageView] = []
  var images: [UIImage] = [UIImage(named: "pic_agony")!,
                           UIImage(named: "pic_depression")!,
                           UIImage(named: "pic_gaming")!,
                           UIImage(named: "pic_science")!,
                           UIImage(named: "pic_tech")!,
                           UIImage(named: "pic_movies")!]
  
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
    
    self.addSubview(imageViewCurrent)
    
    imageViewCurrent.image = UIImage(named: "collection_bg")
    imageViewCurrent.contentMode = .scaleAspectFill
    
    for image in images {
      let imageView = UIImageView()
      imageView.contentMode = .scaleAspectFill
      imageView.image = image
      imageViews.append(imageView)
    }
    
    for imageView in imageViews {
      self.addSubview(imageView)
    }
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    imageViewCurrent.frame = self.bounds
    
    for imageView in imageViews {
      imageView.frame = self.bounds
    }
  }
  
  func scrollFunc(scrollView: UIScrollView) {
    let w = self.bounds.width
    let offset = scrollView.contentOffset.x
    let page = Int(scrollView.contentOffset.x / self.bounds.width)
    print(offset)
    print(page)
    
    imageViews[imageViews.count - 1 - page].alpha = 1 - (CGFloat((Int(offset) % Int(w))) / CGFloat(w))
    self.setNeedsDisplay()
    self.layoutIfNeeded()
    
  }
  
}
