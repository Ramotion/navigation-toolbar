//
//  TopViewAnimators.swift
//  NavigationToolbar
//
//  Created by obozhdi on 22/05/2018.
//  Copyright © 2018 ramotion. All rights reserved.
//

import UIKit

public protocol LayoutAttributesAnimator {
  func animate(collectionView: UICollectionView, attributes: AnimatedCollectionViewLayoutAttributes)
}

public struct FadeAnimator: LayoutAttributesAnimator {
  public init() {}
  
  public func animate(collectionView: UICollectionView, attributes: AnimatedCollectionViewLayoutAttributes) {
    let position      = attributes.middleOffset
    let contentOffset = collectionView.contentOffset
    
    attributes.frame = CGRect(x: contentOffset.x + abs(position) * 5, y: contentOffset.y, width: attributes.frame.width, height: attributes.frame.height)
    attributes.alpha = 1 - abs(position)
  }
}

public struct MovementAnimator: LayoutAttributesAnimator {
  public var minAlpha    : CGFloat
  public var itemSpacing : CGFloat
  public var scaleRate   : CGFloat
  
  public init(minAlpha: CGFloat = 0.5, itemSpacing: CGFloat = 0.6, scaleRate: CGFloat = 1) {
    self.minAlpha    = minAlpha
    self.itemSpacing = itemSpacing
    self.scaleRate   = scaleRate
  }
  
  public func animate(collectionView: UICollectionView, attributes: AnimatedCollectionViewLayoutAttributes) {
    let position       = attributes.middleOffset
    let scaleFactor    = scaleRate - 0.1 * abs(position)
    let scaleTransform = CGAffineTransform(scaleX : scaleFactor, y : scaleFactor)
    
    let translationTransform: CGAffineTransform
    
    if attributes.scrollDirection == .horizontal {
      let width            = collectionView.frame.width
      let translationX     = -(width * itemSpacing * position)
      translationTransform = CGAffineTransform(translationX : translationX, y : 0)
    } else {
      let height           = collectionView.frame.height
      let translationY     = -(height * itemSpacing * position)
      translationTransform = CGAffineTransform(translationX : 0, y : translationY)
    }
    
    attributes.alpha     = 1.0 - abs(position) + minAlpha
    attributes.transform = translationTransform.concatenating(scaleTransform)
  }
}
