//
//  NavigationView.swift
//  NavigationToolbar
//
//  Created by Artem P. on 22/05/2018.
//  Copyright © 2018 Ramotion. All rights reserved.
//

import UIKit

enum State {
    case horizontal
    case vertical
}

open class NavigationView: UIView {
    
    private var backGroundImageView = UIImageView()
    private var topView = TopView()
    private var middleView: UIView!
    private var bottomView = BottomView()
    private var fullscreenView = FulllscreenView()
    private var panRecognizer: PanDirectionGestureRecognizer!
    private var screens: [ScreenObject]!
    private var backgroundImage: UIImage!
    
    public var currentIndex: Int = 0 {
        didSet {
            topView.currentIndex = currentIndex
            fullscreenView.currentIndex = currentIndex
            bottomView.currentIndex = currentIndex
        }
    }
    
    private var middleOriginY: CGFloat = Settings.Sizes.navbarSize {
        didSet {
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
    
    public init(frame: CGRect, middleView: UIView, screens: [ScreenObject], backgroundImage: UIImage) {
        self.middleView = middleView
        self.screens = screens
        self.backgroundImage = backgroundImage
      
        super.init(frame: frame)
      
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        setup()
    }
    
    private func setup() {
        setData()
      
        backGroundImageView.image = UIImage(named: "background")
        
        topView.backgroundColor = .clear
        bottomView.backgroundColor = .white
        bottomView.delegate = self
        topView.delegate = self
        
        fullscreenView.delegate = self
        
        addSubview(backGroundImageView)
        addSubview(fullscreenView)
        addSubview(topView)
        addSubview(bottomView)
        addSubview(middleView)
        
        panRecognizer = PanDirectionGestureRecognizer(direction: .vertical,
                                                      target: self,
                                                      action: #selector(processPan))
        
        panRecognizer.delaysTouchesBegan = false
        panRecognizer.delaysTouchesEnded = false
        
        panRecognizer.delegate = self
        addGestureRecognizer(panRecognizer!)
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        if middleOriginY < Settings.Sizes.navbarSize { middleOriginY = Settings.Sizes.navbarSize }
        
        backGroundImageView.frame = bounds
        
        topView.frame = CGRect(x: 0,
                               y: 0,
                               width: bounds.width,
                               height: Settings.Sizes.middleSize)
        
        middleView.frame = CGRect(x: 0,
                                  y: middleOriginY,
                                  width: bounds.width,
                                  height: Settings.Sizes.middleViewSize)
        
        topView.setSizingViewHeight(height: middleView.frame.minY)
        
        bottomView.frame = CGRect(x: 0,
                                  y: middleView.frame.maxY,
                                  width: bounds.width,
                                  height: bounds.height - middleView.frame.maxY)
        
        fullscreenView.frame = bounds
        
        fullscreenView.progress = getNormalizedProgress()
        
        topView.setSizingViewProgress(progress: (middleView.frame.origin.y - Settings.Sizes.navbarSize) / (Settings.Sizes.middleSize - Settings.Sizes.navbarSize))
        
        if fullscreenView.state == .vertical {
            fullscreenView.setScrollOffset()
        }
        
        if middleOriginY > bounds.height {
            panRecognizer.isEnabled = false
            fullscreenView.updateVerticalScrollInsets()
        }
    }
  
    public func setMiddleView(middleView: UIView) {
      self.middleView = middleView
      self.setNeedsLayout()
      self.setNeedsDisplay()
      self.layoutIfNeeded()
    }
    
    public func setData() {
        var titles: [String]  = []
        var images: [UIImage] = []
        var controllers: [UIViewController]  = []
        
        for screen in screens {
            titles.append(screen.title)
            images.append(UIImage.makeImageWithGradient(image: screen.image,
                                                        imageAlpha: Settings.imageAlpha,
                                                        startColor: screen.startColor,
                                                        endColor: screen.endColor))
            controllers.append(screen.controller)
        }
        
        topView.setData(titles: titles, images: images)
        fullscreenView.setData(titles: titles, images: images)
        bottomView.setData(controllers: controllers)
      
        backGroundImageView.image = backgroundImage
    }
    
}

extension NavigationView {
    
    @objc private func processPan() {
        var translation = panRecognizer.translation(in: self)
        
        var canPan: Bool = false
        
        let controlRect: CGRect = CGRect(x: 0,
                                         y: 0,
                                         width: bounds.width,
                                         height: middleOriginY + Settings.Sizes.middleViewSize)
        
        let touchLocation = panRecognizer.location(in: self)
        
        let velocity = panRecognizer.velocity(in: self)
        
        if controlRect.contains(touchLocation) {
            canPan = true
        }
        
        if bottomView.canScrollDown {
            canPan = true
        }
        
        var currentDirection: Int = 0
        
        if velocity.y > 0 {
            currentDirection = 2
        } else {
            currentDirection = 1
        }
        
        if currentDirection == 1 && middleOriginY >= Settings.Sizes.middleSize {
            bottomView.canScroll = false
        } else {
            bottomView.canScroll = true
        }
        
        switch panRecognizer.state {
        case .began, .changed:
            if canPan {
                topView.isScrollingEnabled = false
                bottomView.isScrollingEnabled = false
                middleOriginY = middleView.frame.origin.y + translation.y
                if middleOriginY < Settings.Sizes.navbarSize { middleOriginY = Settings.Sizes.navbarSize }
                if translation.y < Settings.Sizes.navbarSize { translation.y = Settings.Sizes.navbarSize }
                
                if 0...Settings.Sizes.navbarSize ~= middleOriginY {
                    topView.isHidden = false
                    topView.hideSizingView()
                    topView.toggleTopStateViews()
                    fullscreenView.state = .horizontal
                    fullscreenView.updateHorizontalScrollInsets()
                } else if Settings.Sizes.navbarSize + 1..<Settings.Sizes.middleSize ~= middleOriginY {
                    topView.isHidden = false
                    topView.toggleMiddleStateViews()
                    topView.showSizingView()
                    fullscreenView.isHidden = true
                    fullscreenView.state = .horizontal
                    fullscreenView.updateHorizontalScrollInsets()
                    fullscreenView.updateVerticalScrollInsets()
                } else if Settings.Sizes.middleSize == middleOriginY {
                    topView.isHidden = false
                    topView.hideSizingView()
                    fullscreenView.isHidden = true
                    fullscreenView.state = .vertical
                    fullscreenView.updateVerticalScrollInsets()
                } else if Settings.Sizes.middleSize + 1..<bounds.height * 2 ~= middleOriginY {
                    topView.isHidden = true
                    topView.hideSizingView()
                    fullscreenView.isHidden = false
                    fullscreenView.state = .vertical
                    fullscreenView.updateVerticalScrollInsets()
                    fullscreenView.resetAlpha()
                } else if middleOriginY > bounds.height {
                    fullscreenView.isHidden = false
                    panRecognizer.isEnabled = false
                    fullscreenView.updateVerticalScrollInsets()
                    canPan = false
                    fullscreenView.resetAlpha()
                }
            }
            
        case .possible, .ended, .cancelled, .failed:
            topView.isScrollingEnabled = true
            bottomView.isScrollingEnabled = true
            if 0...Settings.Sizes.middleSizeHalf ~= middleOriginY {
                UIView.animate(withDuration: Settings.animationsDuration, animations: {
                    self.middleOriginY = Settings.Sizes.navbarSize
                    self.topView.setSizingViewProgress(progress: 0.0)
                }) { _ in
                    self.topView.hideSizingView()
                    self.topView.isHidden = false
                    self.topView.toggleTopStateViews()
                    self.fullscreenView.updateHorizontalScrollInsets()
                }
            } else if Settings.Sizes.middleSizeHalf + 1...Settings.Sizes.middleSize ~= middleOriginY {
                UIView.animate(withDuration: Settings.animationsDuration, animations: {
                    self.middleOriginY = Settings.Sizes.middleSize
                    self.topView.setSizingViewProgress(progress: 1.0)
                }) { _ in
                    self.topView.hideSizingView()
                    self.topView.isHidden = false
                    self.topView.toggleMiddleStateViews()
                    self.fullscreenView.updateHorizontalScrollInsets()
                }
            } else if Settings.Sizes.middleSize + 1...bounds.height * 0.75 ~= middleOriginY {
                UIView.animate(withDuration: Settings.animationsDuration, animations: {
                    self.middleOriginY = Settings.Sizes.middleSize
                }) { _ in
                    self.topView.hideSizingView()
                    self.topView.isHidden = false
                    self.fullscreenView.isHidden = true
                    self.topView.toggleMiddleStateViews()
                    self.fullscreenView.updateVerticalScrollInsets()
                }
            } else if bounds.height * 0.75 + 1...bounds.height ~= middleOriginY {
                UIView.animate(withDuration: Settings.animationsDuration, animations: {
                    self.middleOriginY = self.bounds.height
                }) { _ in
                    self.topView.hideSizingView()
                    self.fullscreenView.updateVerticalScrollInsets()
                    self.panRecognizer.isEnabled = false
                }
            }
            
        }
        panRecognizer.setTranslation(CGPoint.zero, in: self)
    }
    
}

extension NavigationView: UIGestureRecognizerDelegate {
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool { return true }
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool { return false }
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool { return false }
    
    override open func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let velocity = panRecognizer.velocity(in: self)
        return fabs(velocity.y) > fabs(velocity.x)
    }
    
}

extension NavigationView: FulllscreenViewDelegate {
    
    func didTapCell(index: Int) {
        currentIndex = index
        topView.updateOffsets()
        bottomView.updateOffsets()
        panRecognizer.isEnabled = true
        
        UIView.animate(withDuration: Settings.animationsDuration, delay: 0.0, options: .curveEaseOut, animations: {
            self.middleOriginY = Settings.Sizes.middleSize
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }) { completed in
            if completed {
                self.topView.isHidden = false
                self.fullscreenView.isHidden = true
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
            
            return (middleView.frame.minY - Settings.Sizes.middleSize) / diff > 1.0 ? 1.0 : (middleView.frame.minY - Settings.Sizes.middleSize) / diff
        }
        if middleView.frame.origin.y > bounds.height {
            return 1.0
        }
        
        return 0.0
    }
}

extension NavigationView: BottomViewDelegate {
    
    func bottomDidScroll(offset: CGFloat) {
        topView.currentOffset = offset
        topView.updateIndex()
    }
}

extension NavigationView: TopViewDelegate {
    
    func topDidScroll(offset: CGFloat) {
        bottomView.currentOffset = offset
        topView.updateIndex()
    }
}
