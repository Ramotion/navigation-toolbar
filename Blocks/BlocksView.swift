//
//  Copyright © 2018 Ramotion. All rights reserved.
//

import UIKit
import Foundation

enum State {
  case top
  case mid
  case bot
}

class BlocksView: UIView {
  private var controllers: [UIViewController] = []
  private var views: [CellView] = []
  
  private var underlayImageView: UIImageView = UIImageView()
  private var underlayTransitionImageView: UIImageView = UIImageView()
  
  private var midView: AnimationMiddleView = AnimationMiddleView()
  private var botView: AnimationBottomView = AnimationBottomView()
  
  private var scrollContentSize: CGSize {
    get {
      let w = UIScreen.main.bounds.width * CGFloat(controllers.count - 1)
      let h = CGFloat(controllers.count - 1) * Layout.TopView.botSize + CGFloat(controllers.count - 1) * Layout.TopView.botInterval
   
      return CGSize(width: w, height: h)
    }
  }

  private var scrollview: UIScrollView = UIScrollView()
  
  private var rectsTop: [CGRect] = []
  private var rectsMid: [CGRect] = []
  private var rectsBot: [CGRect] = []
  
  private var currentIndex: Int = 0 {
    didSet {
      let gradient    : UIImage = UIImage.imageWithGradient(from    : UIColor.red, to    : UIColor.blue)
      let mergedImage : UIImage = UIImage.mergeImages(bottom : gradient, top : images[currentIndex])
      underlayTransitionImageView.image = mergedImage
    }
  }
  
  private var transitionFactor     : CGFloat = 0
  private var transitionFactorTemp : CGFloat = 0
  
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
          for view in views {
            view.setState(state: state)
          }
        } else {
          underlayTransitionImageView.isHidden = false
        }
        scrollview.contentInset = UIEdgeInsets(top: -rectsTop[0].minY, left: 0, bottom: -rectsTop[0].maxY, right: 0)
      case .bot:
        underlayTransitionImageView.isHidden = true
        scrollview.contentInset = UIEdgeInsets(top: -rectsBot[0].minY, left: -rectsTop[Int(currentIndex)].minX, bottom: rectsBot[0].minY, right: -(scrollview.contentSize.width - rectsTop[0].maxX))
//scrollview.contentInset = .zero
        for view in views {
          view.setState(state: state)
        }
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
  
  init(objects: [BigObject]) {
    super.init(frame:.zero)
    
    for object in objects {
      self.controllers.append(object.controller)
      self.images.append(object.image)
      self.strings.append(object.title)
    }
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
  
  var images: [UIImage] = []
  var strings: [String] = []
  
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
    
    botView.setControllers(controllers: self.controllers)
    
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
    for i in 0..<controllers.count - 1 {
      let view = CellView()
      view.setData(data: (text: strings[i], image: images[i]), index: i)
      
      views.append(view)
    }
    
    for view in views {
      view.delegate = self
      scrollview.addSubview(view)
    }
  }
  
  private func makeTopRects(index: CGFloat) {
    rectsTop = []
    var counter: Int = 0
    let w = UIScreen.main.bounds.width
    let scrollH = scrollContentSize.height
    
    var preservedW: CGFloat = 0
    if rectsTop.isEmpty == false {
      preservedW = rectsTop[Int(index)].minY
    }
    
    for _ in 0..<controllers.count - 1 {
      let rect = CGRect(x: preservedW + CGFloat(counter) * w, y: scrollH / 2 - Layout.TopView.topSize / 2 - 20, width: w, height: 64)
      rectsTop.append(rect)
      counter += 1
    }
  }
  
  private func makeMidRects(index: CGFloat) {
    rectsMid = []
    var counter: Int = 0
    let w = UIScreen.main.bounds.width
    
    var preservedW: CGFloat = 0
//    if rectsMid.isEmpty == false {
//      preservedW = rectsMid[Int(index)].minY
//    }
//
    
    for _ in 0..<controllers.count - 1 {
      let rect = CGRect(x: preservedW + CGFloat(counter) * w, y: rectsTop[counter].minY, width: w, height: Layout.TopView.midSize)
      rectsMid.append(rect)
      counter += 1
      
    }
    
    scrollview.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: -rectsTop[0].maxY, right: 0)
  }
  
  private func makeBotRects(index: CGFloat) {
    rectsBot = []
    var counter: Int = 0
    let vertical: Int = Int(Layout.TopView.botInterval)
    let w = UIScreen.main.bounds.width
    
    let preservedH = rectsTop[Int(index)].minY
    print("b")
    for _ in 0..<controllers.count - 1 {
      let rect = CGRect(x: w * CGFloat(index), y: preservedH + (CGFloat(counter) * Layout.TopView.botSize + CGFloat(counter) * CGFloat(vertical)), width: w, height: Layout.TopView.botSize)
      rectsBot.append(rect)
      counter += 1
      print(rect)
    }
    print("e")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    underlayImageView.frame = self.bounds
    
    scrollview.contentSize = scrollContentSize
//    print("\(scrollview.contentSize) \(scrollview.contentOffset)")
    let w = UIScreen.main.bounds.width
    let h = UIScreen.main.bounds.height
    
    scrollview.frame = self.bounds
    
    switch state {
    case .top:
      for i in 0..<controllers.count - 1 {
        views[i].frame = rectsTop[i]
      }
      underlayTransitionImageView.frame = CGRect(x: 0, y: 0, width: rectsTop[0].width, height: rectsTop[0].height)
      scrollview.isPagingEnabled        = true
      midView.frame = CGRect(x: 0, y: 64, width: w, height: Layout.MidView.height)
      botView.frame = CGRect(x: 0, y: midView.frame.maxY, width: w, height: Layout.BotView.heightTop)
    case .mid:
      for i in 0..<controllers.count - 1 {
        views[i].frame = rectsMid[i]
      }
      underlayTransitionImageView.frame = CGRect(x: 0, y: 0, width: rectsMid[0].width, height: rectsMid[0].height)
      scrollview.isPagingEnabled        = true
      midView.frame = CGRect(x: 0, y: UIScreen.main.bounds.height / 2 - 37.5, width: w, height: Layout.MidView.height)
      botView.frame = CGRect(x: 0, y: midView.frame.maxY, width: w, height: Layout.BotView.heightMid)
      scrollview.contentOffset.x = self.bounds.width * CGFloat(self.currentIndex)
    case .bot:
      for i in 0..<controllers.count - 1 {
        views[i].frame = rectsBot[i]
      }
      scrollview.isPagingEnabled = false
      midView.frame = CGRect(x: 0, y: h, width: w, height: Layout.MidView.height)
      botView.frame = CGRect(x: 0, y: midView.frame.maxY, width: w, height: Layout.BotView.heightMid)
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
  
  func didTapCell(index: Int, cell: CellView) {
    if state == .bot {
      currentIndex = index
      
//      verticalOffset = CGFloat(index) * Layout.TopView.botSize + CGFloat(index) * Layout.TopView.botInterval
      
      makeTopRects(index: CGFloat(index))
      makeMidRects(index: CGFloat(index))
//      makeBotRects(index: CGFloat(index))
      
//      scrollview.contentOffset.x = self.bounds.width * CGFloat(index)
      
      state = .mid
      
      botView.setActiveView(index: index)
    }
  }
  
}
