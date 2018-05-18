//
//  Copyright © 2018 Ramotion. All rights reserved.
//

import UIKit
import Foundation

enum State {
  case horizontal
  case vertical
}

class NavigationToolbarView: UIView {
  private var screens               : [ScreenObject] = []
  private var cellViews             : [CellView]     = []
  
  private var backgroundImageView : UIImageView      = UIImageView()
  private var topView             : AnimationTopView = AnimationTopView()
  
  private var middleView           : AnimationMiddleView = AnimationMiddleView()
  private var middleViewFrameIsSet : Bool                = true
  private var bottomView           : AnimationBottomView = AnimationBottomView()
  
  private var mainScrollview: UIScrollView = UIScrollView()
  
  private var panRecognizer: UIPanGestureRecognizer!
  
  private var bottomScrollContentSize: CGSize {
    get {
      let w = self.bounds.width * CGFloat(screens.count)
      let h = CGFloat(screens.count) * (Layout.TopView.bottomStateSize + Layout.TopView.bottomStateInterval)
   
      return CGSize(width: w, height: h)
    }
  }
  
  private var track: Bool = true
  
  private var duration: Double = 0.25
  
  private var currentIndex: Int = 0
  
  private var needMakeHorizontalFrames : Bool = true
  private var shouldShowSCALV          : Bool = true
  private var menuIsOpen               : Bool = false
  
  private var prevState: State = .horizontal
  private var state: State = .horizontal {
    didSet {
      mainScrollview.isScrollEnabled = false
      
      self.prevState = oldValue
      
      switch state {
      case .horizontal:
        mainScrollview.isPagingEnabled = true
        mainScrollview.contentInset = UIEdgeInsets.zero
        menuIsOpen = false
        for cell in cellViews {
          cell.isHidden = true
        }
        
      case .vertical:
        mainScrollview.isPagingEnabled = false
        mainScrollview.contentInset = UIEdgeInsets(top: 0, left: -(cellViews[currentIndex].frame.minX), bottom: 0, right: -1 * (self.mainScrollview.contentSize.width - ((cellViews.last?.frame.maxX)!)))
        menuIsOpen = true
        for cell in cellViews {
          cell.isHidden = false
        }
      }
      
      setViewsState(progress: getNormalizedProgress(), state: state)
      
      self.mainScrollview.isScrollEnabled = true
    }
  }
  
  private var menuButton: AnimationProgressButton = AnimationProgressButton()
  
  init(screens: [ScreenObject]) {
    super.init(frame:.zero)
    
    self.screens = screens
    
    setup()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  var scrollBg = UIView()
  
  private func setup() {
    self.backgroundColor = .gray
    
    backgroundImageView.image         = UIImage(named :"collection_bg")
    backgroundImageView.contentMode   = .scaleAspectFill
    backgroundImageView.clipsToBounds = true
    
    self.panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(processPan))
  
    bottomView.setScreens(screens: self.screens)
    bottomView.scrollView.delegate                     = self
    
    mainScrollview.delegate                 = self
    mainScrollview.clipsToBounds            = false
    mainScrollview.backgroundColor          = UIColor.clear
    mainScrollview.isPagingEnabled          = true
    mainScrollview.bounces                  = false
    mainScrollview.isDirectionalLockEnabled = true
    mainScrollview.decelerationRate         = 1.0
    
    if #available(iOS 11.0, *) {
      mainScrollview.contentInsetAdjustmentBehavior = .never
    }
    
    scrollBg.backgroundColor = UIColor.darkGray
    
    menuButton.setTitle("", for: .normal)
    menuButton.addTarget(self, action: #selector(tapMenuButton), for: .touchUpInside)
    
    self.addSubview(backgroundImageView)
    self.addSubview(topView)
    self.makeCells()
    self.addSubview(mainScrollview)
    self.addSubview(bottomView)
    self.addSubview(middleView)
    self.addSubview(menuButton)
    
    self.middleView.addGestureRecognizer(panRecognizer!)
    
    mainScrollview.contentInset = UIEdgeInsets(top: 0, left: -((cellViews.first?.frame.minX)!), bottom: -((cellViews.last?.frame.maxY)!), right: -1 * (self.mainScrollview.contentSize.width - ((cellViews.last?.frame.maxX)!)))
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    backgroundImageView.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)

    mainScrollview.contentSize = bottomScrollContentSize
    let w = self.bounds.width
    
    mainScrollview.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
 
    if middleViewFrameIsSet {
      middleView.frame = CGRect(x: 0, y: Layout.TopView.topStateSize, width: self.bounds.width, height: Layout.MidView.height)
      middleViewFrameIsSet = false
    }
    topView.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: Layout.TopView.middleStateSize)
    
    bottomView.frame = CGRect(x: 0, y: middleView.frame.maxY, width: CGFloat(w), height: self.bounds.height - middleView.frame.maxY)
    
    for i in 0..<cellViews.count {
      cellViews[i].frame = makeFrames()[i]
    }
    if state == .vertical {
      setScrollOffset()
    }
    
    let prog = (middleView.frame.origin.y - Layout.TopView.topStateSize) / (Layout.TopView.middleStateSize - Layout.TopView.topStateSize)
    
    topView.scalingView.progress = prog
    
    menuButton.frame = CGRect(x: 8, y: 22, width: 32, height: 32)
  }
  
  @objc private func tapMenuButton() {
    if !menuIsOpen {
      self.state = .vertical
      self.topView.scalingView.isHidden = true
      self.menuButton.animate(progress: 1.0, duration: duration)
      UIView.animate(withDuration: duration, animations: {
        self.topView.state = .bottomSize
        self.middleView.frame.origin.y = self.bounds.height
        self.setNeedsLayout()
        self.layoutIfNeeded()
      }) { (completed) in
        self.mainScrollview.contentInset = UIEdgeInsets(top: 0, left: -(self.cellViews[self.currentIndex].frame.minX), bottom: 0, right: -1 * (self.mainScrollview.contentSize.width - ((self.cellViews.last?.frame.maxX)!)))
        self.menuIsOpen = true
      }
    } else {
      self.menuButton.animate(progress: 0.0, duration: duration)
      UIView.animate(withDuration: duration, animations: {
        self.middleView.frame.origin.y = Layout.TopView.middleStateSize
        self.setNeedsLayout()
        self.layoutIfNeeded()
      }) { (completed) in
        self.menuIsOpen = false
        self.state = .horizontal
        self.topView.state = .middleSize
      }
    }
  }
  
}

extension NavigationToolbarView: UIScrollViewDelegate, AnimationTopViewDelegate {
  
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    updateIndex()
    self.mainScrollview.isScrollEnabled = true
    self.bottomView.scrollView.isScrollEnabled = true
  }
  
  func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    updateIndex()
    self.mainScrollview.isScrollEnabled = true
    self.bottomView.scrollView.isScrollEnabled = true
  }
  
  func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
    self.mainScrollview.isScrollEnabled = true
    self.bottomView.scrollView.isScrollEnabled = true
  }
  
  func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
    self.mainScrollview.isScrollEnabled = true
    self.bottomView.scrollView.isScrollEnabled = true
  }
  
  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    self.mainScrollview.isScrollEnabled = true
    self.bottomView.scrollView.isScrollEnabled = true
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if self.mainScrollview.isTracking {
      bottomView.scrollView.contentOffset.x = self.mainScrollview.contentOffset.x
      bottomView.scrollView.isScrollEnabled = false
      syncOffsets()
    }
    if bottomView.scrollView.isTracking {
      self.mainScrollview.contentOffset.x = bottomView.scrollView.contentOffset.x
      self.mainScrollview.isScrollEnabled = false
      syncOffsets()
    }
    
    if self.mainScrollview.isDragging {
      bottomView.scrollView.contentOffset.x = self.mainScrollview.contentOffset.x
      bottomView.scrollView.isScrollEnabled = false
      syncOffsets()
    }
    if bottomView.scrollView.isDragging {
      self.mainScrollview.contentOffset.x = bottomView.scrollView.contentOffset.x
      self.mainScrollview.isScrollEnabled = false
      syncOffsets()
    }
    
    if self.mainScrollview.isDecelerating {
      bottomView.scrollView.contentOffset.x = self.mainScrollview.contentOffset.x
      bottomView.scrollView.isScrollEnabled = false
      syncOffsets()
    }
    if bottomView.scrollView.isDecelerating {
      self.mainScrollview.contentOffset.x = bottomView.scrollView.contentOffset.x
      self.mainScrollview.isScrollEnabled = false
      syncOffsets()
    }
  }
  
  func setScrollOffset(offset: CGFloat) {
    self.mainScrollview.contentOffset.x = offset
    bottomView.scrollView.contentOffset.x = self.mainScrollview.contentOffset.x
    bottomView.scrollView.isScrollEnabled = false
  }
  
  private func syncOffsets() {
    topView.collectionViewNavbar?.contentOffset.x   = self.mainScrollview.contentOffset.x
    topView.collectionViewMidText?.contentOffset.x  = self.mainScrollview.contentOffset.x
    topView.collectionViewMidImage?.contentOffset.x = self.mainScrollview.contentOffset.x
  }
  
  private func updateIndex() {
    if state != .vertical {
      currentIndex = Int(CGFloat(Int(mainScrollview.contentOffset.x / self.bounds.width)))
      topView.index = currentIndex
      
      let image = screens[currentIndex].image
        
      let gradient    : UIImage = UIImage.imageWithGradient(from    : UIColor.red, to    : UIColor.blue)
      let mergedImage : UIImage = UIImage.mergeImages(bottom : gradient, top : image)
      
      var left = ""
      var right = ""
      
      if currentIndex == 0 {
        left = ""
        right = screens[currentIndex + 1].title
      } else if currentIndex == 1 {
        left = screens[currentIndex - 1].title
        right = screens[currentIndex + 1].title
      } else if currentIndex == screens.count - 1 {
        left = screens[currentIndex - 1].title
        right = ""
      } else if currentIndex == screens.count - 2 {
        left = screens[currentIndex - 1].title
        right = screens[currentIndex + 1].title
      } else {
        left = screens[currentIndex - 1].title
        right = screens[currentIndex + 1].title
      }
      
      topView.scalingView.setData(title: screens[currentIndex].title, image: mergedImage, left: left, right: right)
    }
  }
  
}

extension NavigationToolbarView {
  
  @objc private func processPan() {
    let location = panRecognizer.location(in: self)
    
    self.topView.scalingView.isHidden = false
    
    switch panRecognizer.state {
    case .began, .changed:
      track = true
      self.middleView.frame.origin.y = location.y - Layout.MidView.half
      self.topView.scalingView.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.middleView.frame.minY)
      
      self.topView.setNeedsLayout()
      self.topView.layoutIfNeeded()
      self.setNeedsLayout()
      self.layoutIfNeeded()
      
      if 0...Layout.TopView.topStateSize ~= location.y - Layout.MidView.half {
        self.state = .horizontal
        self.topView.state = .navbarSize
      }
      if Layout.TopView.topStateSize + 1...Layout.TopView.middleStateSize ~= location.y - Layout.MidView.half {
        self.state = .horizontal
        self.topView.state = .middleSize
      } else {
        self.state = .vertical
        self.mainScrollview.contentInset = UIEdgeInsets(top: 0, left: -(cellViews[currentIndex].frame.minX), bottom: 0, right: -1 * (self.mainScrollview.contentSize.width - ((cellViews.last?.frame.maxX)!)))
      }
      if Layout.TopView.middleStateSize + 1...bounds.height ~= location.y - Layout.MidView.half {
        self.topView.state = .bottomSize
      }
      break
    case .possible, .ended, .cancelled, .failed:
      if 0...Layout.TopView.topStateSize ~= location.y - Layout.MidView.half {
        self.state = .horizontal
        self.topView.scalingView.isHidden = false
        self.topView.state = .navbarSize
        UIView.animate(withDuration: duration, animations: {
          self.middleView.frame.origin.y = Layout.TopView.topStateSize
          self.topView.scalingView.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.middleView.frame.minY)
          self.topView.setNeedsLayout()
          self.topView.layoutIfNeeded()
          self.setNeedsLayout()
          self.layoutIfNeeded()
        }) { (completed) in
          self.topView.state = .navbarSize
        }
      }
      if 0...Layout.TopView.middleStateSize / 2 ~= location.y {
        self.state = .horizontal
        self.topView.scalingView.isHidden = false
        UIView.animate(withDuration: duration, animations: {
          self.middleView.frame.origin.y = Layout.TopView.topStateSize
          self.topView.scalingView.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.middleView.frame.minY)
          self.topView.setNeedsLayout()
          self.topView.layoutIfNeeded()
          self.setNeedsLayout()
          self.layoutIfNeeded()
        }) { (completed) in
          self.topView.state = .navbarSize
        }
      } else if Layout.TopView.middleStateSize / 2 + 1...Layout.TopView.middleStateSize ~= location.y {
        self.state = .horizontal
        self.topView.scalingView.isHidden = false
        UIView.animate(withDuration: duration, animations: {
          self.middleView.frame.origin.y = Layout.TopView.middleStateSize
          self.topView.scalingView.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.middleView.frame.minY)
          self.topView.setNeedsLayout()
          self.topView.layoutIfNeeded()
          self.setNeedsLayout()
          self.layoutIfNeeded()
        }) { (completed) in
          self.topView.state = .middleSize
          self.topView.scalingView.isHidden = true
        }
      } else if Layout.TopView.middleStateSize + 1...bounds.height ~= location.y && track {
        self.state = .vertical
        self.topView.state = .bottomSize
        self.menuButton.animate(progress: 1.0, duration: duration)
        UIView.animate(withDuration: duration, animations: {
          self.middleView.frame.origin.y = self.bounds.height
          self.topView.scalingView.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.middleView.frame.minY)
          self.topView.setNeedsLayout()
          self.topView.layoutIfNeeded()
          self.setNeedsLayout()
          self.layoutIfNeeded()
        }) { (completed) in
          self.mainScrollview.contentInset = UIEdgeInsets(top: 0, left: -(self.cellViews[self.currentIndex].frame.minX), bottom: 0, right: -1 * (self.mainScrollview.contentSize.width - ((self.cellViews.last?.frame.maxX)!)))
        }
      }
      break
    }
  }
  
}

extension NavigationToolbarView {
  
  private func makeCells() {
    for i in 0..<screens.count {
      let view = CellView()
      view.delegate = self
      
      let gradient    : UIImage = UIImage.imageWithGradient(from: screens[i].colorStart, to: screens[i].colorEnd)
      let mergedImage : UIImage = UIImage.mergeImages(bottom : gradient, top : screens[i].image)
      
      view.setData(data: (text: screens[i].title, image: mergedImage), index: i)
      topView.images.append(mergedImage)
      topView.strings.append(screens[i].title)
      cellViews.append(view)
    }
    for view in cellViews {
      mainScrollview.addSubview(view)
    }
    let gradient    : UIImage = UIImage.imageWithGradient(from: screens[currentIndex].colorStart, to: screens[currentIndex].colorEnd)
    let mergedImage : UIImage = UIImage.mergeImages(bottom : gradient, top : screens.first!.image)
    topView.scalingView.setData(title: (screens.first?.title)!, image: mergedImage, left: "", right: screens[1].title)
  }
  
  private func makeFrames() -> [CGRect] {
    var frames: [CGRect] = []

    if state == .horizontal {
      for i in 0..<cellViews.count {
        let frame = CGRect(x: CGFloat(i) * self.bounds.width, y: 0, width: self.bounds.width, height: middleView.frame.minY)
        frames.append(frame)
      }
    } else {
      let vertical : CGFloat = CGFloat(Layout.TopView.bottomStateInterval)
      let progress = getNormalizedProgress()
      let w: CGFloat = self.bounds.width
      
      for i in 0..<cellViews.count {
        let iterator  : CGFloat = CGFloat(i)
        let tempIndex : CGFloat = CGFloat(currentIndex)
        let heightDiff          = Layout.TopView.middleStateSize - Layout.TopView.bottomStateSize

        let frame = CGRect(x: w * iterator + progress * (w * tempIndex - w * iterator),
                           y: (iterator * Layout.TopView.bottomStateSize + iterator * CGFloat(vertical)) * progress,
                       width: w,
                      height: Layout.TopView.middleStateSize - (heightDiff * progress))
        
        frames.append(frame)
        
        cellViews[i].setState(progress: progress, state: state)
      }
    }
    
    return frames
  }
  
  private func getNormalizedProgress() -> CGFloat {
    if Layout.TopView.middleStateSize...self.bounds.height ~= middleView.frame.origin.y {
      let diff: CGFloat = self.bounds.height - Layout.TopView.middleStateSize
      
      menuButton.setProgress((middleView.frame.minY - Layout.TopView.middleStateSize) / diff > 1.0 ? 1.0 : (middleView.frame.minY - Layout.TopView.middleStateSize) / diff) 
      
      return (middleView.frame.minY - Layout.TopView.middleStateSize) / diff > 1.0 ? 1.0 : (middleView.frame.minY - Layout.TopView.middleStateSize) / diff
    }
    
    return 0.0
  }
  
  private func setScrollOffset() {
    let cellView = cellViews.filter({$0.index == Int(currentIndex)}).first
    
    let vertical : CGFloat = CGFloat(Layout.TopView.bottomStateInterval)
    
    let minY = CGFloat(currentIndex) * (Layout.TopView.bottomStateSize + CGFloat(vertical))
    
    let diffX = mainScrollview.contentOffset.x - (cellView?.frame.minX)!
    let diffY = min(minY, self.mainScrollview.contentSize.height - self.bounds.height)
    
    self.mainScrollview.contentOffset.x = (cellView?.frame.minX)! - diffX * getNormalizedProgress()
    self.mainScrollview.contentOffset.y = diffY * getNormalizedProgress()
  }
  
  private func setViewsState(progress: CGFloat, state: State) {
    for view in cellViews {
      view.setState(progress: progress, state: state)
    }
  }
  
}

extension NavigationToolbarView: CellViewDelegate {
  
  func didTapCell(index: Int, cell: CellView) {
    if state == .vertical {
      currentIndex = index
      
      self.menuButton.animate(progress: 0.0, duration: duration)
      UIView.animate(withDuration: duration, animations: {
        self.middleView.frame = CGRect(x: 0, y: Layout.TopView.middleStateSize, width: self.bounds.width, height: Layout.MidView.height)
        self.setNeedsLayout()
        self.layoutIfNeeded()
      } ) { ( completed) in
        if completed {
          self.state = .horizontal
          self.topView.state = .middleSize
          self.mainScrollview.contentInset = UIEdgeInsets(top: 0, left: -((self.cellViews.first?.frame.minX)!), bottom: -((self.cellViews.last?.frame.maxY)!), right: -1 * (self.mainScrollview.contentSize.width - ((self.cellViews.last?.frame.maxX)!)))
          self.track = false
        }
      }
    }
    bottomView.setActiveView(index: index)
    topView.setActiveView(index: index)
  }
  
}
