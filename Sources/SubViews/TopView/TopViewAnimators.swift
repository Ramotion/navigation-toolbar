//
//  TopViewAnimators.swift
//  NavigationToolbar
//
//  Created by Artem P. on 22/05/2018.
//  Copyright © 2018 Ramotion. All rights reserved.
//

import UIKit

protocol LayoutAttributesAnimator {
    func animate(collectionView: UICollectionView, attributes: AnimatedCollectionViewLayoutAttributes)
}

struct FadeAnimator: LayoutAttributesAnimator {
    init() {}
    
    func animate(collectionView: UICollectionView, attributes: AnimatedCollectionViewLayoutAttributes) {
        let position = attributes.middleOffset
        let contentOffset = collectionView.contentOffset
        
        attributes.frame = CGRect(x: contentOffset.x + abs(position) * 5, y: contentOffset.y, width: attributes.frame.width, height: attributes.frame.height)
        attributes.alpha = 1 - abs(position)
    }
}

struct MovementAnimator: LayoutAttributesAnimator {
    var minAlpha: CGFloat
    var itemSpacing: CGFloat
    var scaleRate: CGFloat
    
    public init(minAlpha: CGFloat = 0.3,
                itemSpacing: CGFloat = 0.4,
                scaleRate: CGFloat = 1) {
        self.minAlpha = minAlpha
        self.itemSpacing = itemSpacing
        self.scaleRate = scaleRate
    }
    
    func animate(collectionView: UICollectionView, attributes: AnimatedCollectionViewLayoutAttributes) {
        let position = attributes.middleOffset
        let scaleFactor = scaleRate
        let scaleTransform = CGAffineTransform(scaleX : scaleFactor, y : scaleFactor)
        
        let translationTransform: CGAffineTransform
        
        if attributes.scrollDirection == .horizontal {
            let width = collectionView.frame.width
            let translationX = -(width * itemSpacing * position)
            translationTransform = CGAffineTransform(translationX : translationX, y : 0)
        } else {
            let height = collectionView.frame.height
            let translationY = -(height * itemSpacing * position)
            translationTransform = CGAffineTransform(translationX : 0, y : translationY)
        }
        
        attributes.alpha = 1.0 - abs(position) + minAlpha
        attributes.transform = translationTransform.concatenating(scaleTransform)
    }
}
