import Foundation
import UIKit

class AnimationController: UIViewController {
  
  private var aView = AnimationView()
  
  override func loadView() {
    self.view = aView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = .blue
  }
  
}
