//
//  TopViewCells.swift
//  NavigationToolbar
//
//  Created by Artem P. on 22/05/2018.
//  Copyright © 2018 Ramotion. All rights reserved.
//

import Foundation
import UIKit

class TopViewCellOne: UICollectionViewCell {
    
    var imageView = UIImageView()
    var label = Label.topViewCellLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        backgroundColor = .clear
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        self.addSubview(imageView)
        self.addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        label.frame = CGRect(x: 0,
                             y: Settings.Sizes.yOffset,
                             width: bounds.width,
                             height: bounds.height - Settings.Sizes.yOffset)
        
        imageView.frame = CGRect(x: -Settings.imageCrossOffset,
                                 y: 0,
                                 width: bounds.width + 2 * Settings.imageCrossOffset,
                                 height: bounds.height)
    }
    
    func setData(title: String, image: UIImage) {
        label.text = title
        imageView.image = image
    }
    
}

class TopViewCellTwo: UICollectionViewCell {
    
    var imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        self.addSubview(imageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.frame = CGRect(x: -Settings.imageCrossOffset,
                                 y: 0,
                                 width: bounds.width + 2 * Settings.imageCrossOffset,
                                 height: bounds.height)
    }
    
    func setImage(image: UIImage) {
        imageView.image = image
    }
    
}

class TopViewCellThree: UICollectionViewCell {
    
    var label = Label.topViewCellLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        self.addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        label.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
    }
    
    func setTitle(title: String) {
        label.text = title
    }
    
}
