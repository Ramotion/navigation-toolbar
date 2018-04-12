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
    imageViewCurrent.image = UIImage(named: "collection_bg")
    imageViewTemp.backgroundColor = .purple
    
    self.addSubview(imageViewCurrent)
    self.addSubview(imageViewTemp)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    imageViewCurrent.frame = self.bounds
    imageViewTemp.frame = self.bounds
  }
  
  func scrollFunc(scrollView: UIScrollView) {
//    print("UNDERLAY DELEGATE")
  }
  
}
