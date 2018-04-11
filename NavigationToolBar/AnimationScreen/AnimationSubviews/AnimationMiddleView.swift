import UIKit

protocol AnimationMiddleViewDelegate {
  func moveUp()
  func moveDown()
}

class AnimationMiddleView: UIView {
  
  var delegate: AnimationMiddleViewDelegate?
  
  private var upGesture = UISwipeGestureRecognizer()
  private var downGesture = UISwipeGestureRecognizer()

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
    
    upGesture.direction   = .up
    downGesture.direction = .down
    
    upGesture.addTarget(self, action: #selector(self.up))
    downGesture.addTarget(self, action: #selector(self.down))
    
    self.addGestureRecognizer(upGesture)
    self.addGestureRecognizer(downGesture)
  }
  
  @objc private func up() {
    delegate?.moveUp()
  }
  
  @objc private func down() {
    delegate?.moveDown()
  }

}
