//
//  Copyright © 2018 Ramotion. All rights reserved.
//

import UIKit

struct ScreenObject {
  
  var colorStart: UIColor
  var colorEnd: UIColor
  var title: String
  var image: UIImage
  var controller: UIViewController
  
}

class BlocksController: UIViewController {
  
  private func createObjects() -> [ScreenObject] {
    let obj1 = ScreenObject(colorStart : UIColor.red, colorEnd : UIColor.blue, title : "MOOD", image : UIImage(named : "pic_agony")!, controller : DummyController())
    let obj2 = ScreenObject(colorStart : UIColor.red, colorEnd : UIColor.green, title : "SURVIVAL", image : UIImage(named : "pic_depression")!, controller : DummyController())
    let obj3 = ScreenObject(colorStart : UIColor.red, colorEnd : UIColor.green, title : "GAMING", image : UIImage(named : "pic_gaming")!, controller : DummyController())
    let obj4 = ScreenObject(colorStart : UIColor.red, colorEnd : UIColor.green, title : "MOVIES", image : UIImage(named : "pic_movies")!, controller : DummyController())
    let obj5 = ScreenObject(colorStart : UIColor.red, colorEnd : UIColor.blue, title : "SCIENCE", image : UIImage(named : "pic_science")!, controller : DummyController())
    let obj6 = ScreenObject(colorStart : UIColor.red, colorEnd : UIColor.green, title : "TECHNOLOGY", image : UIImage(named : "pic_tech")!, controller : DummyController())
    let obj7 = ScreenObject(colorStart : UIColor.red, colorEnd : UIColor.green, title : "MUSIC", image : UIImage(named : "pic_depression")!, controller : DummyController())
    let obj8 = ScreenObject(colorStart : UIColor.red, colorEnd : UIColor.blue, title : "DEVELOPMENT", image : UIImage(named : "pic_gaming")!, controller : DummyController())
    
    return [obj1, obj2, obj3, obj4, obj5, obj6, obj7, obj8]
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = .gray
    
    let blocksView = NavigationToolbarView(screens: createObjects())
    blocksView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
    blocksView.clipsToBounds = true
    self.view.addSubview(blocksView)

    if #available(iOS 10.0, *) {
      self.automaticallyAdjustsScrollViewInsets = false
    }
  }
  
}
