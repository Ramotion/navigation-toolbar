//
//  Copyright © 2018 Ramotion. All rights reserved.
//

import UIKit
import UIKit.UIGestureRecognizerSubclass
import Foundation

struct Layout {
  struct TopView {
    static let topSize     : CGFloat = 64
    static let midSize     : CGFloat = UIScreen.main.bounds.height / 2 - 37.5
    static let botSize     : CGFloat = 120
    static let botInterval : CGFloat = 4
  }
  struct MidView {
    static let height : CGFloat = 65
  }
  
  struct BotView {
    static let heightTop : CGFloat = UIScreen.main.bounds.height - Layout.TopView.topSize
    static let heightMid : CGFloat = UIScreen.main.bounds.height - Layout.TopView.midSize
    static let heightBot : CGFloat = UIScreen.main.bounds.height - Layout.TopView.midSize
  }
}

enum State {
  case top
  case mid
  case bot
}

enum Directon {
  case right
  case left
}

enum ScrollDirection {
  case horizontal
  case vertical
}

class BlocksView: UIView {
  
  private var underlayImageView: UIImageView = UIImageView()
  private var underlayTransitionImageView: UIImageView = UIImageView()
  
  private var midView: AnimationMiddleView = AnimationMiddleView()
  private var botView: AnimationBottomView = AnimationBottomView()
  
  private var quantity: Int = 6
  private var scrollContentSize: CGSize {
    get {
      let w = UIScreen.main.bounds.width * CGFloat(quantity)
      let h = CGFloat(quantity) * UIScreen.main.bounds.height + CGFloat(quantity) * CGFloat(10)
      
      return CGSize(width: w, height: h)
    }
  }

  private var scrollview: UIScrollView = UIScrollView()
  private var lastContentOffsetX: CGFloat = 0
  private var lastContentOffsetY: CGFloat = 0
  
  private var views: [CellView] = []
  
  private var rectsTop: [CGRect] = []
  private var rectsMid: [CGRect] = []
  private var rectsBot: [CGRect] = []
  
  private var currentIndex: Int = 0 {
    didSet {
      let gradient    : UIImage = UIImage.imageWithGradient(from    : UIColor.red, to    : UIColor.blue)
      let mergedImage : UIImage = UIImage.mergeImages(bottom : gradient, top : images[Int(currentIndex)])
      underlayTransitionImageView.changeImage(newImage: mergedImage)
    }
  }
  
  private var transitionFactor     : CGFloat = 0
  private var transitionFactorTemp : CGFloat = 0
  
  private var verticalOffset: CGFloat = 0
  private var prevState : State = .top
  private var state     : State = .top {
    didSet {
      prevState = oldValue
      
      scrollview.isScrollEnabled = false
      
      switch state {
      case .top:
        if prevState == .bot {
          underlayTransitionImageView.isHidden = true
        } else {
          underlayTransitionImageView.isHidden = false
        }
        scrollview.contentInset = UIEdgeInsets(top: -rectsTop[0].minY, left: 0, bottom: -rectsTop[0].maxY, right: 0)
      case .mid:
        if prevState == .bot {
          underlayTransitionImageView.isHidden = true
        } else {
          underlayTransitionImageView.isHidden = false
        }
        scrollview.contentInset = UIEdgeInsets(top: -rectsTop[0].minY, left: 0, bottom: -rectsTop[0].maxY, right: 0)
      case .bot:
        underlayTransitionImageView.isHidden = true
        scrollview.contentInset = UIEdgeInsets(top: -rectsBot[0].minY, left: -rectsTop[Int(currentIndex)].minX, bottom: -4000, right: -(scrollview.contentSize.width - rectsTop[0].maxX))
      }
      
      for view in views {
        view.setState(state: state)
      }
      
      UIView.animate(withDuration: 0.99, animations: {
        self.setNeedsLayout()
        self.layoutIfNeeded()
      }) { (compelted) in
        self.scrollview.isScrollEnabled = true
        
        if self.prevState == .bot {
          self.underlayTransitionImageView.isHidden = false
        }
      }
    }
  }
  
  private var runningAnimators = [UIViewPropertyAnimator]()
  private var animationProgress = [CGFloat]()
  
  private var direction: Directon = .right {
    didSet {
      switch direction {
      case .right:
        views[Int(currentIndex + 1)].setTransparency(transparency: transitionFactor)
        break
      case .left:
        views[Int(currentIndex)].setTransparency(transparency: transitionFactor)
        if currentIndex - 1 >= 0 {
          views[Int(currentIndex - 1)].setTransparency(transparency: 1 - transitionFactor)
        }
        break
      }
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
  
  ///////////////////DUMMY
  let images: [UIImage] = [UIImage(named: "pic_agony")!,
                           UIImage(named: "pic_depression")!,
                           UIImage(named: "pic_gaming")!,
                           UIImage(named: "pic_movies")!,
                           UIImage(named: "pic_science")!,
                           UIImage(named: "pic_tech")!]
  
  
  let strings: [String] = ["MOOD",
                           "SURVIVAL",
                           "GAMING",
                           "MOVIES",
                           "SCIENCE",
                           "TECHNOLOGY",
                           ]
  
  private func setup() {
    self.backgroundColor = .gray
    
    underlayImageView.image       = UIImage(named : "collection_bg")
    underlayImageView.contentMode = .scaleAspectFill
    
    let gradient    : UIImage = UIImage.imageWithGradient(from    : UIColor.red, to    : UIColor.blue)
    let mergedImage : UIImage = UIImage.mergeImages(bottom : gradient, top : images[0])
    underlayTransitionImageView.image         = mergedImage
    underlayTransitionImageView.contentMode   = .scaleAspectFill
    underlayTransitionImageView.clipsToBounds = true
    underlayTransitionImageView.isHidden      = false
    
    midView.delegate = self
    
    var controllers: [UIViewController] = []
    for _ in strings {
      controllers.append(DummyController())
    }
    botView.setControllers(controllers: controllers)
    
    scrollview.delegate                 = self
    botView.scrollView.delegate         = self
    scrollview.bounces                  = false
    scrollview.isDirectionalLockEnabled = true
    scrollview.decelerationRate         = 1.0
    scrollview.backgroundColor          = .clear
    
    if #available(iOS 11.0, *) {
      scrollview.contentInsetAdjustmentBehavior = .never
    }
    
    self.addSubview(underlayImageView)
    self.addSubview(underlayTransitionImageView)
    self.addSubview(scrollview)
    self.addSubview(midView)
    self.addSubview(botView)
    
    makeViews()
    makeTopRects(index: CGFloat(currentIndex))
    scrollview.contentInset = UIEdgeInsets(top: -rectsTop[0].minY, left: 0, bottom: -rectsTop[0].maxY, right: 0)
    makeMidRects(index: CGFloat(currentIndex))
    makeBotRects(index: CGFloat(currentIndex))
    
    scrollview.setContentOffset(CGPoint(x: 0, y: scrollContentSize.height / 2 - Layout.TopView.topSize / 2 - 20), animated: false)
    
    state = .top
  }
  
  private func makeViews() {
    for i in 0..<quantity {
      let view = CellView()
      view.setData(data: (text: strings[i], image: images[i]), index: i)
      view.setTransparency(transparency: 0)
      
      views.append(view)
    }
    
    views[0].setTransparency(transparency: 1.0)
    
    for view in views {
      view.delegate = self
      scrollview.addSubview(view)
    }
  }
  
  private func makeTopRects(index: CGFloat) {
    verticalOffset = 0
    var counter: Int = 0
    let w = UIScreen.main.bounds.width
    let scrollH = scrollContentSize.height
    
    var preservedW: CGFloat = 0
    if rectsTop.isEmpty == false {
      preservedW = rectsTop[Int(index)].minY
    }
    
    for _ in 0..<quantity {
      let rect = CGRect(x: preservedW + CGFloat(counter) * w, y: scrollH / 2 - Layout.TopView.topSize / 2 - 20, width: w, height: 64)
      rectsTop.append(rect)
      counter += 1
    }
  }
  
  private func makeMidRects(index: CGFloat) {
    var counter: Int = 0
    let w = UIScreen.main.bounds.width
    
    var preservedW: CGFloat = 0
    if rectsMid.isEmpty == false {
      preservedW = rectsMid[Int(index)].minY
    }
    
    for _ in 0..<quantity {
      let rect = CGRect(x: preservedW + CGFloat(counter) * w, y: verticalOffset + rectsTop[counter].minY, width: w, height: Layout.TopView.midSize)
      rectsMid.append(rect)
      counter += 1
    }
    scrollview.contentInset = UIEdgeInsets(top: -verticalOffset, left: 0, bottom: -rectsTop[0].maxY, right: 0)
  }
  
  private func makeBotRects(index: CGFloat) {
    rectsBot = []
    var counter: Int = 0
    let vertical: Int = Int(Layout.TopView.botInterval)
    let w = UIScreen.main.bounds.width
    
    let preservedH = rectsTop[Int(index)].minY
    
    for _ in 0...quantity {
      let rect = CGRect(x: w * CGFloat(index), y: preservedH + (CGFloat(counter) * Layout.TopView.botSize + CGFloat(counter) * CGFloat(vertical)), width: w, height: Layout.TopView.botSize)
      rectsBot.append(rect)
      counter += 1
    }
    self.setNeedsLayout()
    self.layoutIfNeeded()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    underlayImageView.frame = self.bounds
    
    scrollview.contentSize = scrollContentSize
    
    let w = UIScreen.main.bounds.width
    let h = UIScreen.main.bounds.height
    
    scrollview.frame = self.bounds
    
    switch state {
    case .top:
      for i in 0..<quantity {
        views[i].frame = rectsTop[i]
      }
      underlayTransitionImageView.frame = CGRect(x: 0, y: 0, width: rectsTop[0].width, height: rectsTop[0].height)
      scrollview.isPagingEnabled        = true
      midView.frame = CGRect(x: 0, y: Layout.TopView.topSize, width: w, height: Layout.MidView.height)
      botView.frame = CGRect(x: 0, y: midView.frame.maxY, width: w, height: Layout.BotView.heightTop)
    case .mid:
      for i in 0..<quantity {
        views[i].frame = rectsMid[i]
      }
      underlayTransitionImageView.frame = CGRect(x: 0, y: 0, width: rectsMid[0].width, height: rectsMid[0].height)
      scrollview.isPagingEnabled        = true
      midView.frame = CGRect(x: 0, y: Layout.TopView.midSize, width: w, height: Layout.MidView.height)
      botView.frame = CGRect(x: 0, y: midView.frame.maxY, width: w, height: Layout.BotView.heightMid)
    case .bot:
      for i in 0..<quantity {
        views[i].frame = rectsBot[i]
      }
      scrollview.isPagingEnabled = false
      midView.frame = CGRect(x: 0, y: h, width: w, height: Layout.MidView.height)
      botView.frame = CGRect(x: 0, y: midView.frame.maxY, width: w, height: Layout.BotView.heightMid)
    }
  }
  
  private func updateDirection(scrollView: UIScrollView) {
    var transitionFactor = (scrollView.contentOffset.x / self.bounds.width) - CGFloat(currentIndex)
    
    if transitionFactor > transitionFactorTemp {
      direction = .right
    } else {
      direction = .left
    }
    
    if transitionFactor < 0 {
      transitionFactor += 1
    }
    
    if transitionFactor == 0 {
      transitionFactor = 0.01
    }
    
    for view in views {
      view.setTransparency(transparency: transitionFactor)
    }
  }
  
}

extension BlocksView: UIScrollViewDelegate {
  
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    updateIndex()
  }
  
  func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    updateIndex()
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if self.scrollview.isTracking {
      botView.scrollView.contentOffset.x = self.scrollview.contentOffset.x
    }
    if botView.scrollView.isTracking {
      self.scrollview.contentOffset.x = botView.scrollView.contentOffset.x
    }
    
    if self.scrollview.isDragging {
      botView.scrollView.contentOffset.x = self.scrollview.contentOffset.x
    }
    if botView.scrollView.isDragging {
      self.scrollview.contentOffset.x = botView.scrollView.contentOffset.x
    }
    
    if self.scrollview.isDecelerating {
      botView.scrollView.contentOffset.x = self.scrollview.contentOffset.x
    }
    if botView.scrollView.isDecelerating {
      self.scrollview.contentOffset.x = botView.scrollView.contentOffset.x
    }
  }
  
  private func updateIndex() {
    if state != .bot {
      currentIndex = Int(CGFloat(Int(scrollview.contentOffset.x / UIScreen.main.bounds.width)))
    }
  }
  
}

extension BlocksView: AnimationMiddleViewDelegate {
  func moveUp() {
    switch state {
    case .top:
      state = .top
    case .mid:
      makeTopRects(index: CGFloat(currentIndex))
      state = .top
    case .bot:
      makeMidRects(index: CGFloat(currentIndex))
      state = .mid
    }
  }
  
  func moveDown() {
    switch state {
    case .top:
      state = .mid
    case .mid:
      makeBotRects(index: CGFloat(currentIndex))
      state = .bot
    case .bot:
      state = .bot
    }
  }
  
}

extension BlocksView: CellViewDelegate {
  
  func didTapCell(index: Int) {
    if state == .bot {
      currentIndex = index
      
      verticalOffset = CGFloat(index) * Layout.TopView.botSize + CGFloat(index) * Layout.TopView.botInterval
      
      makeTopRects(index: CGFloat(index))
      makeMidRects(index: CGFloat(index))
      makeBotRects(index: CGFloat(index))
      
      scrollview.contentOffset.x = self.bounds.width * CGFloat(index)
      
      state = .mid
      
      botView.setActiveView(index: index)
    }
  }
  
}
