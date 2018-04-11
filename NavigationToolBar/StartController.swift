import Foundation
import UIKit

class StartController: UIViewController {
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    self.view.backgroundColor = .green
    
    self.present(AnimationController(), animated: true, completion: nil)
  }
  
}
