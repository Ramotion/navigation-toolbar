//
//  Copyright © 2018 Ramotion. All rights reserved.
//

import Foundation
import UIKit

public class AnimatedCollectionViewLayout: UICollectionViewFlowLayout {
  
  public var animator: LayoutAttributesAnimator?
  
  public override class var layoutAttributesClass: AnyClass { return AnimatedCollectionViewLayoutAttributes.self }
  
  public override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    guard let attributes = super.layoutAttributesForElements(in: rect) else { return nil }
    return attributes.compactMap { $0.copy() as? AnimatedCollectionViewLayoutAttributes }.map { self.transformLayoutAttributes($0) }
  }
  
  public override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool { return true }
  
  private func transformLayoutAttributes(_ attributes: AnimatedCollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
    guard let collectionView = self.collectionView else { return attributes }
    
    let a = attributes
    
    let distance   : CGFloat
    let itemOffset : CGFloat
    
    if scrollDirection == .horizontal {
      distance      = collectionView.frame.width
      itemOffset    = a.center.x - collectionView.contentOffset.x
      a.startOffset = (a.frame.origin.x - collectionView.contentOffset.x) / a.frame.width
      a.endOffset   = (a.frame.origin.x - collectionView.contentOffset.x - collectionView.frame.width) / a.frame.width
    } else {
      distance      = collectionView.frame.height
      itemOffset    = a.center.y - collectionView.contentOffset.y
      a.startOffset = (a.frame.origin.y - collectionView.contentOffset.y) / a.frame.height
      a.endOffset   = (a.frame.origin.y - collectionView.contentOffset.y - collectionView.frame.height) / a.frame.height
    }
    
    a.scrollDirection = scrollDirection
    a.middleOffset = itemOffset / distance - 0.5
    
    if a.contentView == nil,
      let c = collectionView.cellForItem(at: attributes.indexPath)?.contentView {
      a.contentView = c
    }
    
    animator?.animate(collectionView: collectionView, attributes: a)
    
    return a
  }
  
}

public class AnimatedCollectionViewLayoutAttributes: UICollectionViewLayoutAttributes {
  
  public var contentView     : UIView?
  public var scrollDirection : UICollectionViewScrollDirection = .vertical
  
  public var startOffset  : CGFloat = 0
  public var middleOffset : CGFloat = 0
  public var endOffset    : CGFloat = 0
  
  public override func copy(with zone: NSZone? = nil) -> Any {
    let copy             = super.copy(with: zone) as! AnimatedCollectionViewLayoutAttributes
    copy.contentView     = contentView
    copy.scrollDirection = scrollDirection
    copy.startOffset     = startOffset
    copy.middleOffset    = middleOffset
    copy.endOffset       = endOffset
    return copy
  }
  
  public override func isEqual(_ object: Any?) -> Bool {
    guard let o = object as? AnimatedCollectionViewLayoutAttributes else { return false }
    
    return super.isEqual(o)
      && o.contentView     == contentView
      && o.scrollDirection == scrollDirection
      && o.startOffset     == startOffset
      && o.middleOffset    == middleOffset
      && o.endOffset       == endOffset
  }
  
}
