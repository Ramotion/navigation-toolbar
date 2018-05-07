//
//  Copyright © 2018 Ramotion. All rights reserved.
//

import UIKit

protocol AnimationTransitionViewDelegate {
  func setScrollOffset(offset: CGFloat)
}

class AnimationTransitionView: UIView {
  
  var delegate: AnimationTransitionViewDelegate?
  
  var collectionViewNavbar   : UICollectionView!
  var collectionViewMidImage : UICollectionView!
  var collectionViewMidText  : UICollectionView!
  
  var scalingView: AnimationScalingView = AnimationScalingView()
  
  var index: Int = 0
  var currentHeight: CGFloat = 64
  
  private var direction: UICollectionViewScrollDirection = .horizontal
  
  var images: [UIImage] = [] {
    didSet {
      collectionViewNavbar.reloadData()
      collectionViewMidImage.reloadData()
      collectionViewMidText.reloadData()
    }
  }
  var strings: [String] = []
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    setup()
  }
  
  private func setup() {
    collectionViewNavbar                                 = UICollectionView(frame : .zero, collectionViewLayout : AnimatedCollectionViewLayout())
    collectionViewNavbar.delegate                        = self
    collectionViewNavbar.dataSource                      = self
    collectionViewNavbar.backgroundView?.backgroundColor = .clear
    collectionViewNavbar.backgroundColor                 = .clear
    collectionViewNavbar.register(TransitionCellOne.self, forCellWithReuseIdentifier: "TransitionCellOne")
    collectionViewNavbar.isHidden = false
    
    collectionViewMidImage                                 = UICollectionView(frame : .zero, collectionViewLayout : AnimatedCollectionViewLayout())
    collectionViewMidImage.delegate                        = self
    collectionViewMidImage.dataSource                      = self
    collectionViewMidImage.backgroundView?.backgroundColor = .clear
    collectionViewMidImage.backgroundColor                 = .clear
    collectionViewMidImage.register(TransitionCellTwo.self, forCellWithReuseIdentifier: "TransitionCellTwo")
    collectionViewMidImage.isHidden = false
    
    collectionViewMidText                                 = UICollectionView(frame : .zero, collectionViewLayout : AnimatedCollectionViewLayout())
    collectionViewMidText.delegate                        = self
    collectionViewMidText.dataSource                      = self
    collectionViewMidText.backgroundView?.backgroundColor = .clear
    collectionViewMidText.backgroundColor                 = .clear
    collectionViewMidText.register(TransitionCellThree.self, forCellWithReuseIdentifier: "TransitionCellThree")
    collectionViewMidText.isHidden = false
    
    scalingView.backgroundColor = .red
    scalingView.isHidden        = true
    
    setLayout()
    
    addSubview(collectionViewMidImage)
    addSubview(collectionViewMidText)
    addSubview(collectionViewNavbar)
    addSubview(scalingView)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    let w = self.bounds.width
    
    collectionViewNavbar.frame   = CGRect(x : 0, y : 0, width : w, height : Layout.TopView.topStateSize)
    collectionViewMidImage.frame = CGRect(x : 0, y : 0, width : w, height : Layout.TopView.middleStateSize)
    collectionViewMidText.frame  = CGRect(x : 0, y : 0, width : w, height : Layout.TopView.middleStateSize)
    scalingView.frame            = CGRect(x : 0, y : 0, width : w, height : currentHeight)
  }
  
  private func setLayout() {
    if let layout = collectionViewNavbar?.collectionViewLayout as? AnimatedCollectionViewLayout {
      layout.scrollDirection = direction
      layout.animator = FadeAnimator()
      collectionViewNavbar?.isPagingEnabled = true
    }
    
    if let layout = collectionViewMidImage?.collectionViewLayout as? AnimatedCollectionViewLayout {
      layout.scrollDirection = direction
      layout.animator = FadeAnimator()
      collectionViewMidImage?.isPagingEnabled = true
    }
    
    if let layout = collectionViewMidText?.collectionViewLayout as? AnimatedCollectionViewLayout {
      layout.scrollDirection = direction
      layout.animator = MovementAnimator()
      collectionViewMidText?.isPagingEnabled = true
    }
  }
  
  func setActiveView(index: Int) {
    collectionViewNavbar.contentOffset.x   = self.bounds.width * CGFloat(index)
    collectionViewMidImage.contentOffset.x = self.bounds.width * CGFloat(index)
    collectionViewMidText.contentOffset.x  = self.bounds.width * CGFloat(index)
    
    var left = ""
    var right = ""
    
    if index == 0 {
      left = ""
      right = strings[index + 1]
    } else if index == 1 {
      left = strings[index - 1]
      right = strings[index + 1]
    } else if index == strings.count - 1 {
      left = strings[index - 1]
      right = ""
    } else if index == strings.count - 2 {
      left = strings[index - 1]
      right = strings[index + 1]
    } else {
      left = strings[index - 1]
      right = strings[index + 1]
    }
    
    scalingView.setData(title: strings[index], image: images[index], left: left, right: right)
  }
  
}

extension AnimationTransitionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return images.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    switch collectionView {
    case collectionViewNavbar:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TransitionCellOne", for: indexPath) as! TransitionCellOne
      cell.backgroundColor = .clear
      cell.setImage(title: strings[indexPath.row], image: images[indexPath.row])
      return cell
    case collectionViewMidImage:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TransitionCellTwo", for: indexPath) as! TransitionCellTwo
      cell.backgroundColor = .clear
      cell.setImage(title: strings[indexPath.row], image: images[indexPath.row])
      return cell
    case collectionViewMidText:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TransitionCellThree", for: indexPath) as! TransitionCellThree
      cell.backgroundColor = .clear
      cell.setImage(title: strings[indexPath.row], image: images[indexPath.row])
      return cell
    default:
      break
    }
    
    
    return UICollectionViewCell()
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: self.bounds.width, height: collectionView.frame.height)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return .zero
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
}

extension AnimationTransitionView: UIScrollViewDelegate {
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    delegate?.setScrollOffset(offset: scrollView.contentOffset.x)
    
    if collectionViewMidText.isTracking {
      collectionViewNavbar.contentOffset.x = collectionViewMidText.contentOffset.x
      collectionViewMidImage.contentOffset.x = collectionViewMidText.contentOffset.x
    }
    if collectionViewMidText.isDragging {
      collectionViewNavbar.contentOffset.x = collectionViewMidText.contentOffset.x
      collectionViewMidImage.contentOffset.x = collectionViewMidText.contentOffset.x
    }
    if collectionViewMidText.isDecelerating {
      collectionViewNavbar.contentOffset.x = collectionViewMidText.contentOffset.x
      collectionViewMidImage.contentOffset.x = collectionViewMidText.contentOffset.x
    }
    
    if collectionViewNavbar.isTracking {
      collectionViewMidText.contentOffset.x = collectionViewNavbar.contentOffset.x
      collectionViewMidImage.contentOffset.x = collectionViewNavbar.contentOffset.x
    }
    if collectionViewNavbar.isDragging {
      collectionViewMidText.contentOffset.x = collectionViewNavbar.contentOffset.x
      collectionViewMidImage.contentOffset.x = collectionViewNavbar.contentOffset.x
    }
    if collectionViewNavbar.isDecelerating {
      collectionViewMidText.contentOffset.x = collectionViewNavbar.contentOffset.x
      collectionViewMidImage.contentOffset.x = collectionViewNavbar.contentOffset.x
    }
  }
  
}
