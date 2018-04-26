//
//  Copyright © 2018 Ramotion. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
  
  convenience init(hex: String) {
    let scanner = Scanner(string: hex)
    scanner.scanLocation = 0
    
    var rgbValue: UInt64 = 0
    
    scanner.scanHexInt64(&rgbValue)
    
    let r = (rgbValue & 0xff0000) >> 16
    let g = (rgbValue & 0xff00) >> 8
    let b = rgbValue & 0xff
    
    self.init(
      red: CGFloat(r) / 0xff,
      green: CGFloat(g) / 0xff,
      blue: CGFloat(b) / 0xff, alpha: 1
    )
  }
  
}

extension UIImage {
  
  static func imageWithGradient(from beginColor: UIColor, to endColor: UIColor) -> UIImage {
    let layer = CAGradientLayer()
    layer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height / 2 - 37.5)
    layer.colors = [beginColor.cgColor, endColor.cgColor]
    layer.startPoint = CGPoint(x: 0, y: 0.5)
    layer.endPoint = CGPoint(x: 1, y: 0.5)
    UIGraphicsBeginImageContext(CGSize(width: layer.frame.width, height: layer.frame.height))
    layer.render(in: UIGraphicsGetCurrentContext()!)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image!
  }
  
  static func mergeImages(bottom: UIImage, top: UIImage) -> UIImage {
    let bottomImage = bottom
    let topImage = top
    
    let size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2 - 37.5)
    UIGraphicsBeginImageContext(size)
    
    let areaSize = CGRect(x: 0, y: 0, width: size.width, height: size.height)
    bottomImage.draw(in: areaSize)
    
    topImage.draw(in: areaSize, blendMode: .normal, alpha: 0.2)
    
    let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    
    return newImage
  }
  
}

extension UIImageView {
  
  func changeImage(newImage: UIImage) {
    guard let currentImage = self.image, currentImage != newImage else { return }
    let animation = CATransition()
    animation.duration = 0.3
    animation.type = kCATransitionFade
    layer.add(animation, forKey: "ImageFade")
    self.image = newImage
  }
  
}
