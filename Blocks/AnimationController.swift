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
    let obj01 = ScreenObject(colorStart: UIColor.init(hex: "FDEB71"), colorEnd: UIColor.init(hex: "F8D800"), title: "SOMETITLE", image: UIImage(named : "pic_agony")!, controller: DummyController())
    let obj02 = ScreenObject(colorStart: UIColor.init(hex: "ABDCFF"), colorEnd: UIColor.init(hex: "0396FF"), title: "SOMETITLE", image: UIImage(named : "pic_agony")!, controller: DummyController())
    let obj03 = ScreenObject(colorStart: UIColor.init(hex: "FEB692"), colorEnd: UIColor.init(hex: "EA5455"), title: "SOMETITLE", image: UIImage(named : "pic_agony")!, controller: DummyController())
    let obj04 = ScreenObject(colorStart: UIColor.init(hex: "CE9FFC"), colorEnd: UIColor.init(hex: "7367F0"), title: "SOMETITLE", image: UIImage(named : "pic_agony")!, controller: DummyController())
    let obj05 = ScreenObject(colorStart: UIColor.init(hex: "90F7EC"), colorEnd: UIColor.init(hex: "32CCBC"), title: "SOMETITLE", image: UIImage(named : "pic_agony")!, controller: DummyController())
    let obj06 = ScreenObject(colorStart: UIColor.init(hex: "FFF6B7"), colorEnd: UIColor.init(hex: "F6416C"), title: "SOMETITLE", image: UIImage(named : "pic_agony")!, controller: DummyController())
    let obj07 = ScreenObject(colorStart: UIColor.init(hex: "81FBB8"), colorEnd: UIColor.init(hex: "28C76F"), title: "SOMETITLE", image: UIImage(named : "pic_agony")!, controller: DummyController())
    let obj08 = ScreenObject(colorStart: UIColor.init(hex: "E2B0FF"), colorEnd: UIColor.init(hex: "9F44D3"), title: "SOMETITLE", image: UIImage(named : "pic_agony")!, controller: DummyController())
    let obj09 = ScreenObject(colorStart: UIColor.init(hex: "F97794"), colorEnd: UIColor.init(hex: "623AA2"), title: "SOMETITLE", image: UIImage(named : "pic_agony")!, controller: DummyController())
    let obj10 = ScreenObject(colorStart: UIColor.init(hex: "FCCF31"), colorEnd: UIColor.init(hex: "F55555"), title: "SOMETITLE", image: UIImage(named : "pic_agony")!, controller: DummyController())
    let obj11 = ScreenObject(colorStart: UIColor.init(hex: "F761A1"), colorEnd: UIColor.init(hex: "8C1BAB"), title: "SOMETITLE", image: UIImage(named : "pic_agony")!, controller: DummyController())
    let obj12 = ScreenObject(colorStart: UIColor.init(hex: "43CBFF"), colorEnd: UIColor.init(hex: "9708CC"), title: "SOMETITLE", image: UIImage(named : "pic_agony")!, controller: DummyController())
    let obj13 = ScreenObject(colorStart: UIColor.init(hex: "5EFCE8"), colorEnd: UIColor.init(hex: "736EFE"), title: "SOMETITLE", image: UIImage(named : "pic_agony")!, controller: DummyController())
    let obj14 = ScreenObject(colorStart: UIColor.init(hex: "FAD7A1"), colorEnd: UIColor.init(hex: "E96D71"), title: "SOMETITLE", image: UIImage(named : "pic_agony")!, controller: DummyController())
    let obj15 = ScreenObject(colorStart: UIColor.init(hex: "FFD26F"), colorEnd: UIColor.init(hex: "3677FF"), title: "SOMETITLE", image: UIImage(named : "pic_agony")!, controller: DummyController())
    let obj16 = ScreenObject(colorStart: UIColor.init(hex: "A0FE65"), colorEnd: UIColor.init(hex: "FA016D"), title: "SOMETITLE", image: UIImage(named : "pic_agony")!, controller: DummyController())
    let obj17 = ScreenObject(colorStart: UIColor.init(hex: "FFDB01"), colorEnd: UIColor.init(hex: "0E197D"), title: "SOMETITLE", image: UIImage(named : "pic_agony")!, controller: DummyController())
    let obj18 = ScreenObject(colorStart: UIColor.init(hex: "FEC163"), colorEnd: UIColor.init(hex: "DE4313"), title: "SOMETITLE", image: UIImage(named : "pic_agony")!, controller: DummyController())
    let obj19 = ScreenObject(colorStart: UIColor.init(hex: "92FFC0"), colorEnd: UIColor.init(hex: "002661"), title: "SOMETITLE", image: UIImage(named : "pic_agony")!, controller: DummyController())
    let obj20 = ScreenObject(colorStart: UIColor.init(hex: "EEAD92"), colorEnd: UIColor.init(hex: "6018DC"), title: "SOMETITLE", image: UIImage(named : "pic_agony")!, controller: DummyController())
    let obj21 = ScreenObject(colorStart: UIColor.init(hex: "F6CEEC"), colorEnd: UIColor.init(hex: "D939CD"), title: "SOMETITLE", image: UIImage(named : "pic_agony")!, controller: DummyController())
    let obj22 = ScreenObject(colorStart: UIColor.init(hex: "52E5E7"), colorEnd: UIColor.init(hex: "130CB7"), title: "SOMETITLE", image: UIImage(named : "pic_agony")!, controller: DummyController())
    let obj23 = ScreenObject(colorStart: UIColor.init(hex: "F1CA74"), colorEnd: UIColor.init(hex: "A64DB6"), title: "SOMETITLE", image: UIImage(named : "pic_agony")!, controller: DummyController())
    let obj24 = ScreenObject(colorStart: UIColor.init(hex: "E8D07A"), colorEnd: UIColor.init(hex: "5312D6"), title: "SOMETITLE", image: UIImage(named : "pic_agony")!, controller: DummyController())
    let obj25 = ScreenObject(colorStart: UIColor.init(hex: "EECE13"), colorEnd: UIColor.init(hex: "B210FF"), title: "SOMETITLE", image: UIImage(named : "pic_agony")!, controller: DummyController())
    let obj26 = ScreenObject(colorStart: UIColor.init(hex: "79F1A4"), colorEnd: UIColor.init(hex: "0E5CAD"), title: "SOMETITLE", image: UIImage(named : "pic_agony")!, controller: DummyController())
    let obj27 = ScreenObject(colorStart: UIColor.init(hex: "FDD819"), colorEnd: UIColor.init(hex: "E80505"), title: "SOMETITLE", image: UIImage(named : "pic_agony")!, controller: DummyController())
    let obj28 = ScreenObject(colorStart: UIColor.init(hex: "FFF3B0"), colorEnd: UIColor.init(hex: "CA26FF"), title: "SOMETITLE", image: UIImage(named : "pic_agony")!, controller: DummyController())
    let obj29 = ScreenObject(colorStart: UIColor.init(hex: "FFF5C3"), colorEnd: UIColor.init(hex: "9452A5"), title: "SOMETITLE", image: UIImage(named : "pic_agony")!, controller: DummyController())
    let obj30 = ScreenObject(colorStart: UIColor.init(hex: "F05F57"), colorEnd: UIColor.init(hex: "360940"), title: "SOMETITLE", image: UIImage(named : "pic_agony")!, controller: DummyController())
    let obj31 = ScreenObject(colorStart: UIColor.init(hex: "2AFADF"), colorEnd: UIColor.init(hex: "4C83FF"), title: "SOMETITLE", image: UIImage(named : "pic_agony")!, controller: DummyController())
    let obj32 = ScreenObject(colorStart: UIColor.init(hex: "FFF886"), colorEnd: UIColor.init(hex: "F072B6"), title: "SOMETITLE", image: UIImage(named : "pic_agony")!, controller: DummyController())
    let obj33 = ScreenObject(colorStart: UIColor.init(hex: "97ABFF"), colorEnd: UIColor.init(hex: "123597"), title: "SOMETITLE", image: UIImage(named : "pic_agony")!, controller: DummyController())
    let obj34 = ScreenObject(colorStart: UIColor.init(hex: "F5CBFF"), colorEnd: UIColor.init(hex: "C346C2"), title: "SOMETITLE", image: UIImage(named : "pic_agony")!, controller: DummyController())
    let obj35 = ScreenObject(colorStart: UIColor.init(hex: "FFF720"), colorEnd: UIColor.init(hex: "3CD500"), title: "SOMETITLE", image: UIImage(named : "pic_agony")!, controller: DummyController())
    let obj36 = ScreenObject(colorStart: UIColor.init(hex: "FF6FD8"), colorEnd: UIColor.init(hex: "3813C2"), title: "SOMETITLE", image: UIImage(named : "pic_agony")!, controller: DummyController())
    let obj37 = ScreenObject(colorStart: UIColor.init(hex: "EE9AE5"), colorEnd: UIColor.init(hex: "5961F9"), title: "SOMETITLE", image: UIImage(named : "pic_agony")!, controller: DummyController())
    let obj38 = ScreenObject(colorStart: UIColor.init(hex: "FFD3A5"), colorEnd: UIColor.init(hex: "FD6585"), title: "SOMETITLE", image: UIImage(named : "pic_agony")!, controller: DummyController())
    let obj39 = ScreenObject(colorStart: UIColor.init(hex: "C2FFD8"), colorEnd: UIColor.init(hex: "465EFB"), title: "SOMETITLE", image: UIImage(named : "pic_agony")!, controller: DummyController())
    let obj40 = ScreenObject(colorStart: UIColor.init(hex: "FD6585"), colorEnd: UIColor.init(hex: "0D25B9"), title: "SOMETITLE", image: UIImage(named : "pic_agony")!, controller: DummyController())
    let obj41 = ScreenObject(colorStart: UIColor.init(hex: "FD6E6A"), colorEnd: UIColor.init(hex: "FFC600"), title: "SOMETITLE", image: UIImage(named : "pic_agony")!, controller: DummyController())
    let obj42 = ScreenObject(colorStart: UIColor.init(hex: "65FDF0"), colorEnd: UIColor.init(hex: "1D6FA3"), title: "SOMETITLE", image: UIImage(named : "pic_agony")!, controller: DummyController())
    let obj43 = ScreenObject(colorStart: UIColor.init(hex: "6B73FF"), colorEnd: UIColor.init(hex: "000DFF"), title: "SOMETITLE", image: UIImage(named : "pic_agony")!, controller: DummyController())
    let obj45 = ScreenObject(colorStart: UIColor.init(hex: "FF7AF5"), colorEnd: UIColor.init(hex: "513162"), title: "SOMETITLE", image: UIImage(named : "pic_agony")!, controller: DummyController())
    let obj46 = ScreenObject(colorStart: UIColor.init(hex: "F0FF00"), colorEnd: UIColor.init(hex: "58CFFB"), title: "SOMETITLE", image: UIImage(named : "pic_agony")!, controller: DummyController())
    let obj47 = ScreenObject(colorStart: UIColor.init(hex: "FFE985"), colorEnd: UIColor.init(hex: "FA742B"), title: "SOMETITLE", image: UIImage(named : "pic_agony")!, controller: DummyController())
    let obj48 = ScreenObject(colorStart: UIColor.init(hex: "FFA6B7"), colorEnd: UIColor.init(hex: "1E2AD2"), title: "SOMETITLE", image: UIImage(named : "pic_agony")!, controller: DummyController())
    let obj49 = ScreenObject(colorStart: UIColor.init(hex: "FFAA85"), colorEnd: UIColor.init(hex: "B3315F"), title: "SOMETITLE", image: UIImage(named : "pic_agony")!, controller: DummyController())
    let obj50 = ScreenObject(colorStart: UIColor.init(hex: "72EDF2"), colorEnd: UIColor.init(hex: "5151E5"), title: "SOMETITLE", image: UIImage(named : "pic_agony")!, controller: DummyController())
    let obj51 = ScreenObject(colorStart: UIColor.init(hex: "FF9D6C"), colorEnd: UIColor.init(hex: "BB4E75"), title: "SOMETITLE", image: UIImage(named : "pic_agony")!, controller: DummyController())
    let obj52 = ScreenObject(colorStart: UIColor.init(hex: "F6D242"), colorEnd: UIColor.init(hex: "FF52E5"), title: "SOMETITLE", image: UIImage(named : "pic_agony")!, controller: DummyController())
    
    return [obj01,
            obj02,
            obj03,
            obj04,
            obj05,
            obj06,
            obj07,
            obj08,
            obj09,
            obj10,
//            obj11,
//            obj12,
//            obj13,
//            obj14,
//            obj15,
//            obj16,
//            obj17,
//            obj18,
//            obj19,
//            obj20,
//            obj21,
//            obj22,
//            obj23,
//            obj24,
//            obj25,
//            obj26,
//            obj27,
//            obj28,
//            obj29,
//            obj30,
//            obj31,
//            obj32,
//            obj33,
//            obj34,
//            obj35,
//            obj36,
//            obj37,
//            obj38,
//            obj39,
//            obj40,
//            obj41,
//            obj42,
//            obj43,
//            obj45,
//            obj46,
//            obj47,
//            obj48,
//            obj49,
//            obj50,
//            obj51,
//            obj52
    ]
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
