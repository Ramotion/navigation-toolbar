//
//  SizingView.swift
//  NavigationToolbar
//
//  Created by Artem P. on 22/05/2018.
//  Copyright © 2018 Ramotion. All rights reserved.
//

import UIKit

class SizingView: UIView {
    
    private var imageView: UIImageView = UIImageView()
    private var label = Label.topViewCellLabel()
    private var leftLabel = Label.sideLabel()
    private var rightLabel = Label.sideLabel()
    
    var progress: CGFloat = 0 {
        didSet {
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
    }
    
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
        
        addSubview(imageView)
        addSubview(label)
        
        leftLabel.alpha = 1.0
        addSubview(leftLabel)
        
        rightLabel.alpha = 1.0
        addSubview(rightLabel)
    }
    
    func setData(title: String, image: UIImage, previousTitle: String, nextTitle: String) {
        label.text = title
        imageView.image = image
        leftLabel.text = previousTitle
        rightLabel.text = nextTitle
    }
    
    func animateCollapse() {
        UIView.animate(withDuration: Settings.animationsDuration, animations: {
            let w = self.bounds.width
            let wHalf = self.bounds.width / 2
            let h = self.bounds.height
            
            self.leftLabel.frame = CGRect(x: -w * 0.21 - Settings.Sizes.mainOffset,
                                          y: 0,
                                          width: wHalf,
                                          height: h)
            
            self.rightLabel.frame = CGRect(x: wHalf + w * 0.21 + Settings.Sizes.mainOffset,
                                           y: 0,
                                           width: wHalf,
                                           height: h)
            
            self.bounds = CGRect(x: 0,
                                 y: 0,
                                 width: self.bounds.width,
                                 height: Settings.Sizes.navbarSize)
            
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }) { (completed) in
            
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let w = bounds.width
        let h = bounds.height
        
        imageView.frame = CGRect(x: -Settings.imageCrossOffset,
                                 y: 0,
                                 width: w + 2 * Settings.imageCrossOffset,
                                 height: h)
        
        struct offset {
            static var r: CGFloat {
                get {
                    switch Settings.Sizes.screenWidth {
                    case 320: return 192
                    case 375: return 226
                    case 414: return 249
                    default: return 0
                    }
                }
            }
            static var l: CGFloat {
                get {
                    return offset.r + 1
                }
            }
        }
        
        
        
        if Settings.Sizes.isX {
            label.frame = CGRect(x: 0,
                                 y: Settings.Sizes.yOffset - Settings.Sizes.yOffset * progress,
                                 width: bounds.width,
                                 height: bounds.height - Settings.Sizes.yOffset + Settings.Sizes.yOffset * progress)
            
            rightLabel.frame = CGRect(x: offset.r + (Settings.Sizes.mainOffset - Settings.Sizes.mainOffset * progress),
                                      y: Settings.Sizes.yOffset - Settings.Sizes.yOffset * progress,
                                      width: bounds.width,
                                      height: bounds.height - Settings.Sizes.yOffset + Settings.Sizes.yOffset * progress)
            
            leftLabel.frame = CGRect(x: -offset.l - (Settings.Sizes.mainOffset - Settings.Sizes.mainOffset * progress),
                                     y: Settings.Sizes.yOffset - Settings.Sizes.yOffset * progress,
                                     width: bounds.width,
                                     height: bounds.height - Settings.Sizes.yOffset + Settings.Sizes.yOffset * progress)
        } else {
            label.frame = CGRect(x: 0,
                                 y: Settings.Sizes.yOffset - Settings.Sizes.yOffset * progress,
                                 width: bounds.width,
                                 height: bounds.height - Settings.Sizes.yOffset + Settings.Sizes.yOffset * progress)
            
            rightLabel.frame = CGRect(x: offset.r + (Settings.Sizes.mainOffset - Settings.Sizes.mainOffset * progress),
                                      y: Settings.Sizes.yOffset - Settings.Sizes.yOffset * progress,
                                      width: bounds.width,
                                      height: bounds.height - Settings.Sizes.yOffset + Settings.Sizes.yOffset * progress)
            
            leftLabel.frame = CGRect(x: -offset.l - (Settings.Sizes.mainOffset - Settings.Sizes.mainOffset * progress),
                                     y: Settings.Sizes.yOffset - Settings.Sizes.yOffset * progress,
                                     width: bounds.width,
                                     height: bounds.height - Settings.Sizes.yOffset + Settings.Sizes.yOffset * progress)
        }
        
        leftLabel.alpha  = 0.3
        rightLabel.alpha = 0.3
    }
}
