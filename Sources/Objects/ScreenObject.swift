//
//  ScreenObject.swift
//  NavigationToolbar
//
//  Created by Artem P. on 22/05/2018.
//  Copyright © 2018 Ramotion. All rights reserved.
//

import Foundation
import UIKit

open class ScreenObject {
    
    public let title: String
    public let startColor: UIColor
    public let endColor: UIColor
    public let image: UIImage
    public let controller: UIViewController
    
    public init(title: String = "Screen Title",
         startColor: UIColor = .red,
         endColor: UIColor = .green,
         image: UIImage = UIImage(),
         controller: UIViewController = UIViewController()) {
        
        self.title      = title
        self.startColor = startColor
        self.endColor   = endColor
        self.image      = image
        self.controller = controller
    }
}
