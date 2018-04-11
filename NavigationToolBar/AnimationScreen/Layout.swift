import Foundation
import UIKit

class Layout: UICollectionViewFlowLayout {
  
  var selectedIndex:         Int = -1
  
  private var privateState:  Int = 0
  private var previousState: Int = -1
  
  var state: Int {
    set(newValue) {
      if self.privateState != newValue {
        self.previousState        = self.privateState
        self.privateState         = newValue
        self.privateContentOffset = collectionView?.contentOffset
        
        self.invalidateLayout()
      }
    }
    get {
      return self.privateState
    }
  }
  private var privateContentOffset: CGPoint?
  private var isSetStateTransition = false
  
  override func invalidateLayout() {
    super.invalidateLayout()
  }
  
  override func prepare() {
    if (collectionView == nil) {
      return
    }
    
    itemSize = self.itemSize(state: state)
    self.minimumInteritemSpacing = self.minimumInteritemSpacing(state: state)
    self.minimumLineSpacing      = self.minimumLineSpacing(state: state)
    
    switch state {
      case 0:
        self.scrollDirection                 = .horizontal
        self.collectionView?.isPagingEnabled = true
        self.updateCollectionView()

      case 1:
        self.scrollDirection                 = .horizontal
        self.collectionView?.isPagingEnabled = true
        self.updateCollectionView()

      case 2:
        self.scrollDirection                 = .vertical
        self.collectionView?.isPagingEnabled = false
        self.updateCollectionView()
      
      default:
        break
    }
    
  }
  
  override func shouldInvalidateLayout(forPreferredLayoutAttributes preferredAttributes: UICollectionViewLayoutAttributes, withOriginalAttributes originalAttributes: UICollectionViewLayoutAttributes) -> Bool {
    return super.shouldInvalidateLayout(forPreferredLayoutAttributes: preferredAttributes, withOriginalAttributes: originalAttributes)
  }
  
  override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
    guard var offset = privateContentOffset else {
      return super.targetContentOffset(forProposedContentOffset: proposedContentOffset)
    }
    
    switch self.previousState {
      case 0:
        break
      
      case 1:
        if self.state == 2 {
          let itemIndex = offset.x / self.itemSize(state: self.previousState).width
          offset.x      = 0.0
          
          let addition  = (itemIndex - 2) > -1 ? (itemIndex - 2) : itemIndex
          offset.y      = (self.itemSize.height + self.minimumLineSpacing) * addition
        }
      
      case 2:
        offset.y = 0.0
        offset.x = self.itemSize.width * CGFloat(self.selectedIndex)
      
      default:
        break
    }
    
    return offset
  }
  
  override func initialLayoutAttributesForAppearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
    return self.layoutAttributes(indexPath: itemIndexPath, state: self.previousState)
  }
  
  override func finalLayoutAttributesForDisappearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
    return self.layoutAttributes(indexPath: itemIndexPath, state: self.state)
  }
  
  override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
    return self.layoutAttributes(indexPath: indexPath, state: self.state)
  }
  
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    var attributes = super.layoutAttributesForElements(in: rect)
    var atts = [UICollectionViewLayoutAttributes]()
    
    attributes?.forEach({ (attr) in
      if let atttre = self.layoutAttributes(indexPath: attr.indexPath, state: self.state) {
        atts.append(atttre)
      }
    })
    
    if atts.count > 0 {
      attributes = atts
    }
    
    return attributes
  }
  
  override func prepare(forAnimatedBoundsChange oldBounds: CGRect) {
    super.prepare(forAnimatedBoundsChange: oldBounds)
    self.isSetStateTransition = true
  }
  
  override func finalizeAnimatedBoundsChange() {
    self.isSetStateTransition = false
    super.finalizeAnimatedBoundsChange()
  }
  
  override func prepare(forCollectionViewUpdates updateItems: [UICollectionViewUpdateItem]) {
    super.prepare(forCollectionViewUpdates: updateItems)
  }
  
  override func finalizeCollectionViewUpdates() {
    super.finalizeCollectionViewUpdates()
  }
  
  private func updateCollectionView() {
    guard let collectionView = self.collectionView else {
      return
    }
    
    if self.scrollDirection == .horizontal {
      collectionView.contentInset = UIEdgeInsets(top: 0.0,
                                                left: 0.0,
                                              bottom: collectionView.bounds.height - self.itemSize.height,
                                               right: 0.0)
      
    } else if self.scrollDirection == .vertical {
      collectionView.contentInset = UIEdgeInsets.zero
    }
  }
  
  private func itemSize(state: Int) -> CGSize {
    var size = CGSize.zero
    switch state {
    case 0:
      size = CGSize(width: UIScreen.main.bounds.width, height: AnimationViewSettings.Layout.cellHeightNavbarMode)
    case 1:
      size = CGSize(width: UIScreen.main.bounds.width, height: AnimationViewSettings.Layout.cellHeightHalfScreenMode)
    case 2:
      size = CGSize(width: UIScreen.main.bounds.width, height: AnimationViewSettings.Layout.cellHeightMenuMode)
    default:
      break
    }
    return size
  }
  
  private func layoutAttributes(indexPath: IndexPath, state: Int) -> UICollectionViewLayoutAttributes? {
    guard state > -1 else {
      return nil
    }
    guard let attributes = super.layoutAttributesForItem(at: indexPath) else {
      return nil
    }
    
    switch state {
    case 0:
      attributes.frame = CGRect(x: CGFloat(indexPath.item) * self.itemSize(state: state).width,
                                y: 0.0,
                            width: self.itemSize(state: state).width,
                           height: self.itemSize(state: state).height)
      
    case 1:
      attributes.frame = CGRect(x: CGFloat(indexPath.item) * self.itemSize(state: state).width,
                                y: 0.0,
                            width: self.itemSize(state: state).width,
                           height: self.itemSize(state: state).height)
      
    case 2:
      attributes.frame = CGRect(x: 0,
                                y: CGFloat(indexPath.item) * (self.itemSize(state: state).height + self.minimumLineSpacing(state: state)),
                            width: self.itemSize(state: state).width,
                           height: self.itemSize(state: state).height)
      
    default:
      break
    }
    
    return attributes
  }
  
  private func minimumInteritemSpacing(state: Int) -> CGFloat {
    return 0.0
  }
  
  private func minimumLineSpacing(state: Int) -> CGFloat {
    var spacing = CGFloat(0.0)
    switch state {
    case 0:
      break
    case 1:
      break
    case 2:
      spacing = AnimationViewSettings.Layout.cellSpacingMenuMode
    default:
      break
    }
    return spacing
  }
  
}
