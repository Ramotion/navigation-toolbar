//
//  ViewController.swift
//  NavigationToolbar
//
//  Created by obozhdi on 21/05/2018.
//  Copyright © 2018 ramotion. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var navigationView: NavigationView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationView.setData(screens: createObjects())
  }
  
  override var prefersStatusBarHidden: Bool {
    return true
  }
  
  private func createObjects() -> [ScreenObject] {
    let obj01 = ScreenObject(title: "OBSESSION", startColor: UIColor.init(HEX: "FDEB71"), endColor: UIColor.init(HEX: "F8D800"), image: UIImage(named : "image1")!, controller: DummyController())
    let obj02 = ScreenObject(title: "RECREATION", startColor: UIColor.init(HEX: "ABDCFF"), endColor: UIColor.init(HEX: "0396FF"), image: UIImage(named : "image2")!, controller: DummyController())
    let obj03 = ScreenObject(title: "EDUCATION", startColor: UIColor.init(HEX: "FEB692"), endColor: UIColor.init(HEX: "EA5455"), image: UIImage(named : "image3")!, controller: DummyController())
    let obj04 = ScreenObject(title: "MOVIES", startColor: UIColor.init(HEX: "CE9FFC"), endColor: UIColor.init(HEX: "7367F0"), image: UIImage(named : "image4")!, controller: DummyController())
    let obj05 = ScreenObject(title: "PROGRAMMING", startColor: UIColor.init(HEX: "90F7EC"), endColor: UIColor.init(HEX: "32CCBC"), image: UIImage(named : "image5")!, controller: DummyController())
    let obj06 = ScreenObject(title: "SURFING", startColor: UIColor.init(HEX: "FFF6B7"), endColor: UIColor.init(HEX: "F6416C"), image: UIImage(named : "image6")!, controller: DummyController())
    let obj07 = ScreenObject(title: "FLIGHT", startColor: UIColor.init(HEX: "81FBB8"), endColor: UIColor.init(HEX: "28C76F"), image: UIImage(named : "image7")!, controller: DummyController())
    let obj08 = ScreenObject(title: "MINIMALISM", startColor: UIColor.init(HEX: "E2B0FF"), endColor: UIColor.init(HEX: "9F44D3"), image: UIImage(named : "image8")!, controller: DummyController())
    let obj09 = ScreenObject(title: "DESTRUCTION", startColor: UIColor.init(HEX: "F97794"), endColor: UIColor.init(HEX: "623AA2"), image: UIImage(named : "image9")!, controller: DummyController())
    let obj10 = ScreenObject(title: "POWER", startColor: UIColor.init(HEX: "FCCF31"), endColor: UIColor.init(HEX: "F55555"), image: UIImage(named : "image10")!, controller: DummyController())
    let obj11 = ScreenObject(title: "POLITICS", startColor: UIColor.init(HEX: "F761A1"), endColor: UIColor.init(HEX: "8C1BAB"), image: UIImage(named : "image11")!, controller: DummyController())
    let obj12 = ScreenObject(title: "ELECTRONICS", startColor: UIColor.init(HEX: "43CBFF"), endColor: UIColor.init(HEX: "9708CC"), image: UIImage(named : "image12")!, controller: DummyController())
    let obj13 = ScreenObject(title: "ENGENEERING", startColor: UIColor.init(HEX: "5EFCE8"), endColor: UIColor.init(HEX: "736EFE"), image: UIImage(named : "image13")!, controller: DummyController())
    let obj14 = ScreenObject(title: "PROCRASTINATION", startColor: UIColor.init(HEX: "FAD7A1"), endColor: UIColor.init(HEX: "E96D71"), image: UIImage(named : "image14")!, controller: DummyController())
    let obj15 = ScreenObject(title: "WEALTH", startColor: UIColor.init(HEX: "FFD26F"), endColor: UIColor.init(HEX: "3677FF"), image: UIImage(named : "image15")!, controller: DummyController())

    
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
            obj11,
            obj12,
            obj13,
            obj14,
            obj15
    ]
  }
  
}
