//
//  Copyright © 2018 Ramotion. All rights reserved.
//

import UIKit

struct BigObject {
  
  var colorStart: UIColor
  var colorEnd: UIColor
  var title: String
  var image: UIImage
  var controller: UIViewController
  
}

class BlocksController: UIViewController {
  
  let images: [UIImage] = [UIImage(named: "pic_agony")!,
                           UIImage(named: "pic_depression")!,
                           UIImage(named: "pic_gaming")!,
                           UIImage(named: "pic_movies")!,
                           UIImage(named: "pic_science")!,
                           UIImage(named: "pic_tech")!]
  
  
  let strings: [String] = ["MOOD",
                           "SURVIVAL",
                           "GAMING",
                           "MOVIES",
                           "SCIENCE",
                           "TECHNOLOGY",
                           ]
  
  private func createObjects() -> [BigObject] {
    let obj1 = BigObject(colorStart: UIColor.red, colorEnd: UIColor.green, title: "1", image: UIImage(named : "pic_agony")!, controller: DummyController())
    let obj2 = BigObject(colorStart: UIColor.red, colorEnd: UIColor.green, title: "2", image: UIImage(named : "pic_agony")!, controller: DummyController())
    let obj3 = BigObject(colorStart: UIColor.red, colorEnd: UIColor.green, title: "3", image: UIImage(named : "pic_agony")!, controller: DummyController())
    let obj4 = BigObject(colorStart: UIColor.red, colorEnd: UIColor.green, title: "4", image: UIImage(named : "pic_agony")!, controller: DummyController())
    let obj5 = BigObject(colorStart: UIColor.red, colorEnd: UIColor.green, title: "5", image: UIImage(named : "pic_agony")!, controller: DummyController())
    let obj6 = BigObject(colorStart: UIColor.red, colorEnd: UIColor.green, title: "6", image: UIImage(named : "pic_agony")!, controller: DummyController())
    
    return [obj1, obj2, obj3, obj4, obj5, obj6]
  }
  
  override func loadView() {
    self.view = BlocksView(objects: createObjects())
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if #available(iOS 10.0, *) {
      self.automaticallyAdjustsScrollViewInsets = false
    }
  }
  
}
