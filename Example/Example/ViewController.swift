//
//  ViewController.swift
//  NavigationToolbarDemo
//
//  Created by Artem P. on 21/05/2018.
//  Copyright © 2018 Ramotion. All rights reserved.
//

import UIKit
import NavigationToolbar

class ViewController: UIViewController {

  private var navigationView: NavigationView?

  override func viewDidLoad() {
    super.viewDidLoad()

    navigationView = NavigationView.init(frame: view.bounds, middleView: MiddleView(), screens: createObjects(), backgroundImage: #imageLiteral(resourceName: "background"))
    navigationView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    view.addSubview(navigationView!)
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

    return [obj01,
            obj02,
            obj03,
            obj04,
            obj05,
            obj06,
            obj07,
            obj08
    ]
  }

}
