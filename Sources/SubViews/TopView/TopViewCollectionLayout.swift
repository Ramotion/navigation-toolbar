//
//  TopViewCollectionLayout.swift
//  NavigationToolbar
//
//  Created by Artem P. on 22/05/2018.
//  Copyright © 2018 Ramotion. All rights reserved.
//

import Foundation
import UIKit

class AnimatedCollectionViewLayout: UICollectionViewFlowLayout {
    
    var animator: LayoutAttributesAnimator?
    
    override class var layoutAttributesClass: AnyClass { return AnimatedCollectionViewLayoutAttributes.self }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElements(in: rect) else { return nil }
        return attributes.compactMap { $0.copy() as? AnimatedCollectionViewLayoutAttributes }.map { self.transformLayoutAttributes($0) }
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool { return true }
    
    private func transformLayoutAttributes(_ attributes: AnimatedCollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        guard let collectionView = self.collectionView else { return attributes }
        
        let attrs = attributes
        
        let distance: CGFloat
        let itemOffset: CGFloat
        
        if scrollDirection == .horizontal {
            distance = collectionView.frame.width
            itemOffset = attrs.center.x - collectionView.contentOffset.x
            attrs.startOffset = (attrs.frame.origin.x - collectionView.contentOffset.x) / attrs.frame.width
            attrs.endOffset = (attrs.frame.origin.x - collectionView.contentOffset.x - collectionView.frame.width) / attrs.frame.width
        } else {
            distance = collectionView.frame.height
            itemOffset = attrs.center.y - collectionView.contentOffset.y
            attrs.startOffset = (attrs.frame.origin.y - collectionView.contentOffset.y) / attrs.frame.height
            attrs.endOffset = (attrs.frame.origin.y - collectionView.contentOffset.y - collectionView.frame.height) / attrs.frame.height
        }
        
        attrs.scrollDirection = scrollDirection
        attrs.middleOffset = itemOffset / distance - 0.5
        
        if attrs.contentView == nil,
            let c = collectionView.cellForItem(at: attributes.indexPath)?.contentView {
            attrs.contentView = c
        }
        
        animator?.animate(collectionView: collectionView, attributes: attrs)
        
        return attrs
    }
    
}

public class AnimatedCollectionViewLayoutAttributes: UICollectionViewLayoutAttributes {
    
    var contentView: UIView?
    var scrollDirection: UICollectionView.ScrollDirection = .vertical
    
    var startOffset: CGFloat = 0
    var middleOffset: CGFloat = 0
    var endOffset: CGFloat = 0
    
    public override func copy(with zone: NSZone? = nil) -> Any {
        let copy = super.copy(with: zone) as! AnimatedCollectionViewLayoutAttributes
        copy.contentView = contentView
        copy.scrollDirection = scrollDirection
        copy.startOffset = startOffset
        copy.middleOffset = middleOffset
        copy.endOffset = endOffset
        return copy
    }
    
    public override func isEqual(_ object: Any?) -> Bool {
        guard let o = object as? AnimatedCollectionViewLayoutAttributes else { return false }
        
        return super.isEqual(o)
            && o.contentView == contentView
            && o.scrollDirection == scrollDirection
            && o.startOffset == startOffset
            && o.middleOffset == middleOffset
            && o.endOffset == endOffset
    }
    
}
