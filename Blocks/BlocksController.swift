//
//  Copyright © 2018 Ramotion. All rights reserved.
//

import UIKit

class BlocksController: UIViewController {
  
  override func loadView() {
    self.view = BlocksView()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if #available(iOS 10.0, *) {
      self.automaticallyAdjustsScrollViewInsets = false
    }
  }
  
}
