//
//  NavigationView.swift
//  NavigationToolbar
//
//  Created by obozhdi on 22/05/2018.
//  Copyright © 2018 ramotion. All rights reserved.
//

import UIKit

enum State {
  case horizontal
  case vertical
}

class NavigationView: UIView {
  
  private var backGroundImageView : UIImageView     = UIImageView()
  private var topView             : TopView         = TopView()
  private var middleView          : MiddleView      = MiddleView()
  private var bottomView          : BottomView      = BottomView()
  private var fullscreenView      : FulllscreenView = FulllscreenView()
  private var panRecognizer       : PanDirectionGestureRecognizer!
  private var menuButton          : Button          = Button()
  
  private var menuIsOpen          : Bool            = false
  
  var currentIndex            : Int = 0 {
    didSet {
      topView.currentIndex = currentIndex
      fullscreenView.currentIndex = currentIndex
      bottomView.currentIndex = currentIndex
    }
  }
  
  private var middleOriginY       : CGFloat = Settings.Sizes.navbarSize {
    didSet {
      setNeedsLayout()
      layoutIfNeeded()
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
    backGroundImageView.image = UIImage(named: "background")
    
    topView.backgroundColor    = .clear
    bottomView.backgroundColor = .blue
    
    fullscreenView.delegate = self
    
    menuButton.setTitle("", for: .normal)
    menuButton.addTarget(self, action: #selector(tapMenuButton), for: .touchUpInside)
    
    addSubview(backGroundImageView)
    addSubview(fullscreenView)
    addSubview(topView)
    addSubview(bottomView)
    addSubview(middleView)
    addSubview(menuButton)
    
    panRecognizer = PanDirectionGestureRecognizer(direction: .vertical, target: self, action: #selector(processPan))
    panRecognizer.delegate = self
    addGestureRecognizer(panRecognizer!)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    backGroundImageView.frame = bounds
    
    topView.frame    = CGRect(x : 0, y : 0, width : bounds.width, height : Settings.Sizes.middleSize)
    middleView.frame = CGRect(x : 0, y : middleOriginY, width : bounds.width, height : Settings.Sizes.middleViewSize)
    topView.setSizingViewHeight(height: middleView.frame.minY)
    bottomView.frame = CGRect(x : 0, y : middleView.frame.maxY, width : bounds.width, height : bounds.height - middleView.frame.maxY)
    fullscreenView.frame = bounds
    
    fullscreenView.progress = getNormalizedProgress()
    
    topView.setSizingViewProgress(progress: (middleView.frame.origin.y - Settings.Sizes.navbarSize) / (Settings.Sizes.middleSize - Settings.Sizes.navbarSize))
    
    if fullscreenView.state == .vertical {
      fullscreenView.setScrollOffset()
    }
    
    if Settings.Sizes.isX {
      menuButton.frame = CGRect(x: 16, y: 44, width: 32, height: 32)
    } else {
      menuButton.frame = CGRect(x: 16, y: 26, width: 32, height: 32)
    }
  }
  
  func setData(screens: [ScreenObject]) {
    var titles : [String]  = []
    var images : [UIImage] = []
    var views  : [UIView]  = []
    
    for screen in screens {
      titles.append(screen.title)
      images.append(UIImage.makeImageWithGradient(image: screen.image, imageAlpha: Settings.imageAlpha, startColor: screen.startColor, endColor: screen.endColor))
      views.append(screen.controller.view)
    }
    
    topView.setData(titles: titles, images: images)
    fullscreenView.setData(titles: titles, images: images)
    bottomView.setData(views: views)
  }
  
  @objc private func tapMenuButton() {
    if menuIsOpen == false {
      self.menuIsOpen = true
      self.panRecognizer.isEnabled = false
      fullscreenView.state = .vertical
      topView.hideSizingView()
      topView.isHidden = true
      topView.toggleBottomStateViews()
      self.menuButton.animate(progress: 1.0, duration: Settings.animationsDuration)
      UIView.animate(withDuration: Settings.animationsDuration, animations: {
        self.topView.toggleBottomStateViews()
        self.middleOriginY = self.bounds.height
        self.setNeedsLayout()
        self.layoutIfNeeded()
      }) { (completed) in
        self.fullscreenView.updateHorizontalScrollInsets()
        
      }
    } else {
      self.menuIsOpen = false
      self.panRecognizer.isEnabled = true
      self.menuButton.animate(progress: 0.0, duration: Settings.animationsDuration)
      
      UIView.animate(withDuration: Settings.animationsDuration, animations: {
        self.fullscreenView.scrollView.contentOffset.y = CGFloat(self.currentIndex) * (Settings.menuItemsSpacing + Settings.Sizes.menuItemsSize)
      }) { (completed) in
        if completed {
          UIView.animate(withDuration: Settings.animationsDuration, animations: {
            self.middleOriginY = Settings.Sizes.middleSize
            self.setNeedsLayout()
            self.layoutIfNeeded()
          }) { (completed) in
            self.menuIsOpen = false
            self.fullscreenView.state = .vertical
            self.topView.toggleMiddleStateViews()
          }
        }
      }
    }
  }

}

extension NavigationView {
  
  @objc private func processPan() {
    var canPan: Bool = false
    
    let controlRect: CGRect = CGRect(x: 0, y: 0, width: bounds.width, height: middleView.frame.maxY)
    
    let touchLocation = panRecognizer.location(in: self)
    let translation   = panRecognizer.translation(in: self)
    let velocity      = panRecognizer.velocity(in: self)
    
    var currentDirection: Int = 0
    
    if velocity.y > 0 {
      //      print("panning bottom")
      currentDirection = 2
    } else {
      //      print("panning top")
      currentDirection = 1
    }
    
    if controlRect.contains(touchLocation) && middleOriginY < bounds.height {
      canPan = true
    } else if currentDirection == 2 && !bottomView.shouldBlockPan {
      canPan = true
    } else if currentDirection == 1 && middleOriginY < bounds.height {
      canPan = true
    }
    
    if canPan {
      switch panRecognizer.state {
      case .began, .changed:
        middleOriginY = middleView.frame.origin.y + translation.y
        if middleOriginY < Settings.Sizes.navbarSize { middleOriginY = Settings.Sizes.navbarSize }
        
        if Settings.Sizes.navbarSize == middleOriginY {
          topView.isHidden = false
          topView.hideSizingView()
          fullscreenView.state = .horizontal
          fullscreenView.updateHorizontalScrollInsets()
        } else if Settings.Sizes.navbarSize + 1..<Settings.Sizes.middleSize ~= middleOriginY {
          topView.isHidden = false
          topView.showSizingView()
          fullscreenView.state = .horizontal
          fullscreenView.updateHorizontalScrollInsets()
        } else if Settings.Sizes.middleSize == middleOriginY {
          topView.isHidden = false
          topView.hideSizingView()
          fullscreenView.state = .vertical
          fullscreenView.updateVerticalScrollInsets()
        } else if Settings.Sizes.middleSize + 1..<bounds.height * 2 ~= middleOriginY {
          topView.isHidden = true
          topView.hideSizingView()
          fullscreenView.state = .vertical
          fullscreenView.updateVerticalScrollInsets()
        } else if middleOriginY > bounds.height {
          panRecognizer.isEnabled = false
        }
        
      case .possible, .ended, .cancelled, .failed:
        if 0...Settings.Sizes.middleSize / 2 ~= middleOriginY {
          UIView.animate(withDuration: Settings.animationsDuration, animations: {
            self.middleOriginY = Settings.Sizes.navbarSize
            self.topView.setSizingViewProgress(progress: 0.0)
          }) { _ in
            self.topView.hideSizingView()
            self.topView.isHidden = false
            self.topView.toggleTopStateViews()
            self.fullscreenView.updateHorizontalScrollInsets()
          }
        } else if Settings.Sizes.middleSize / 2 + 1...Settings.Sizes.middleSize ~= middleOriginY {
          UIView.animate(withDuration: Settings.animationsDuration, animations: {
            self.middleOriginY = Settings.Sizes.middleSize
            self.topView.setSizingViewProgress(progress: 1.0)
          }) { _ in
            self.topView.hideSizingView()
            self.topView.isHidden = false
            self.topView.toggleMiddleStateViews()
            self.fullscreenView.updateHorizontalScrollInsets()
          }
        } else if Settings.Sizes.middleSize + 1...bounds.height / 4 * 3 ~= middleOriginY {
          UIView.animate(withDuration: Settings.animationsDuration, animations: {
            self.middleOriginY = Settings.Sizes.middleSize
          }) { _ in
            self.topView.hideSizingView()
            self.topView.isHidden = false
            self.topView.toggleMiddleStateViews()
            self.fullscreenView.updateVerticalScrollInsets()
          }
        } else if bounds.height / 4 * 3 + 1...bounds.height ~= middleOriginY {
          UIView.animate(withDuration: Settings.animationsDuration, animations: {
            self.middleOriginY = self.bounds.height
          }) { _ in
            self.topView.hideSizingView()
            self.fullscreenView.updateVerticalScrollInsets()
            self.panRecognizer.isEnabled = false
            self.menuIsOpen = true
          }
        }
        
      }
      panRecognizer.setTranslation(CGPoint.zero, in: self)
    }
  }
  
}

extension NavigationView: UIGestureRecognizerDelegate {
  
  func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    
    return true
  }
  
}

extension NavigationView: FulllscreenViewDelegate {
  
  func didTapCell(index: Int) {
    self.menuIsOpen = false
//    print("tap cell")
    currentIndex = index
    topView.updateOffsets()
    panRecognizer.isEnabled = true
    
    UIView.animate(withDuration: Settings.animationsDuration, delay: 0.0, options: .curveEaseOut, animations: {
      self.middleOriginY = Settings.Sizes.middleSize
      self.setNeedsLayout()
      self.layoutIfNeeded()
    }) { (completed) in
      if completed {
        self.topView.isHidden = false
        self.topView.toggleMiddleStateViews()
        self.fullscreenView.updateHorizontalScrollInsets()
      }
    }
  }
  
}

extension NavigationView {
  
  private func getNormalizedProgress() -> CGFloat {
    if Settings.Sizes.middleSize...bounds.height ~= middleView.frame.origin.y {
      let diff: CGFloat = bounds.height - Settings.Sizes.middleSize
      
      menuButton.setProgress((middleView.frame.minY - Settings.Sizes.middleSize) / diff > 1.0 ? 1.0 : (middleView.frame.minY - Settings.Sizes.middleSize) / diff)
      
      return (middleView.frame.minY - Settings.Sizes.middleSize) / diff > 1.0 ? 1.0 : (middleView.frame.minY - Settings.Sizes.middleSize) / diff
    }
    if middleView.frame.origin.y > bounds.height {
      return 1.0
    }
    
    return 0.0
  }
  
}
