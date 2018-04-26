//
//  Copyright © 2018 Ramotion. All rights reserved.
//

import Foundation
import UIKit

class Dummies {
  
  class func getDummyCell() -> (text: String, image: UIImage) {
    
    
    let images: [UIImage] = [UIImage(named: "pic_agony")!,
                             UIImage(named: "pic_depression")!,
                             UIImage(named: "pic_gaming")!,
                             UIImage(named: "pic_movies")!,
                             UIImage(named: "pic_science")!,
                             UIImage(named: "pic_tech")!,
                             UIImage(named: "pic_agony")!,
                             UIImage(named: "pic_depression")!,
                             UIImage(named: "pic_gaming")!,
                             UIImage(named: "pic_movies")!,
                             UIImage(named: "pic_science")!,
                             UIImage(named: "pic_tech")!,
                             UIImage(named: "pic_agony")!,
                             UIImage(named: "pic_depression")!,
                             UIImage(named: "pic_gaming")!,
                             UIImage(named: "pic_movies")!,
                             UIImage(named: "pic_science")!,
                             UIImage(named: "pic_tech")!]
    
    
    let strings: [String] = ["pic_agony",
                             "pic_depression",
                             "pic_gaming",
                             "pic_movies",
                             "pic_science",
                             "pic_tech",
                             "pic_agony",
                             "pic_depression",
                             "pic_gaming",
                             "pic_movies",
                             "pic_science",
                             "pic_tech",
                             "pic_agony",
                             "pic_depression",
                             "pic_gaming",
                             "pic_movies",
                             "pic_science",
                             "pic_tech"]
    
    let index = Int(arc4random_uniform(UInt32(images.count)))
    
    return (text: strings[index], image: images[index])
  }
  
}
