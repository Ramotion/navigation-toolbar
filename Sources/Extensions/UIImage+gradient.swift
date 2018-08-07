//
//  UIImage+gradient.swift
//  NavigationToolbar
//
//  Created by Artem P. on 22/05/2018.
//  Copyright © 2018 Ramotion. All rights reserved.
//

import UIKit

extension UIImage {
    
    static func makeImageWithGradient(image: UIImage = UIImage(), imageAlpha: CGFloat = Settings.imageAlpha, startColor: UIColor = UIColor.red, endColor: UIColor = UIColor.blue) -> UIImage {
        let layer = CAGradientLayer()
        layer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: Settings.Sizes.middleSize)
        layer.colors = [startColor.cgColor, endColor.cgColor]
        layer.startPoint = CGPoint(x: 0, y: 0.5)
        layer.endPoint = CGPoint(x: 1, y: 0.5)
        
        UIGraphicsBeginImageContext(CGSize(width: layer.frame.width, height: layer.frame.height))
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let gradientImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return mergeImages(bottom: gradientImage!, top: image, alpha: imageAlpha)
    }
    
    static func mergeImages(bottom: UIImage, top: UIImage, alpha: CGFloat) -> UIImage {
        let bottomImage = bottom
        let topImage = top
        
        let size = CGSize(width: Settings.Sizes.screenWidth, height: Settings.Sizes.middleSize)
        UIGraphicsBeginImageContext(size)
        
        let areaSize = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        bottomImage.draw(in: areaSize)
        
        topImage.draw(in: areaSize, blendMode: .normal, alpha: alpha)
        
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
