//
//  FulllscreenView.swift
//  NavigationToolbar
//
//  Created by Artem P. on 22/05/2018.
//  Copyright © 2018 Ramotion. All rights reserved.
//

import UIKit

protocol FulllscreenViewDelegate {
    func didTapCell(index: Int)
}

class FulllscreenView: UIView {
    
    var scrollView: UIScrollView   = UIScrollView()
    
    var delegate: FulllscreenViewDelegate?
    
    private var animatedViews: [CellView] = []
    private var labelViews: [LabelView] = []
    
    private var images: [UIImage] = []
    private var titles: [String] = []
    
    var progress: CGFloat = 0 {
        didSet {
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
    
    var currentIndex: Int = 0
    
    var state: State = .horizontal {
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
        backgroundColor = .clear
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.alwaysBounceHorizontal = false
        
        addSubview(scrollView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        scrollView.frame = bounds
        scrollView.contentSize = CGSize(width: bounds.width * CGFloat(images.count),
                                        height: CGFloat(images.count) * (Settings.menuItemsSpacing + Settings.Sizes.menuItemsSize))
        
        for i in 0..<animatedViews.count {
            animatedViews[i].frame = makeFrames()[i]
            labelViews[i].frame = animatedViews[i].frame
        }
        
        var prevLabel = Label.sideLabel()
        var nextLabel = Label.sideLabel()
        
        if currentIndex - 1 >= 0 {
            prevLabel = labelViews[currentIndex - 1].label
        }
        if currentIndex + 1 <= labelViews.count - 1 {
            nextLabel = labelViews[currentIndex + 1].label
        }
        
        var right: CGFloat {
            get {
                switch Settings.Sizes.screenWidth {
                case 320: return 128
                case 375: return 150
                case 414: return 166
                default: return 0
                }
            }
        }
        
        for labelView in labelViews {
            if labelView != labelViews[currentIndex] {
                labelView.label.alpha = 0.3 + progress * 0.7
            }
            labelViews[currentIndex].label.alpha = 1.0
        }
        
        prevLabel.frame = CGRect(x: prevLabel.frame.origin.x + right * (1 - progress),
                                 y: prevLabel.frame.origin.y,
                                 width: prevLabel.frame.width,
                                 height: prevLabel.frame.height)
        
        nextLabel.frame = CGRect(x: nextLabel.frame.origin.x - right + right * progress,
                                 y: nextLabel.frame.origin.y,
                                 width: nextLabel.frame.width,
                                 height: nextLabel.frame.height)
    }
    
    func resetAlpha() {
        for label in labelViews {
            label.alpha = 1.0
        }
    }
    
    private func makeViews() {
        for i in 0..<titles.count {
            let animatedView = CellView()
            animatedView.delegate = self
            
            animatedView.setData(title: titles[i], image: images[i], index: i)
            animatedViews.append(animatedView)
        }
        for view in animatedViews {
            scrollView.addSubview(view)
        }
        
        for i in 0..<titles.count {
            let labelView = LabelView()
            labelView.delegate = self
            
            labelView.setData(title: titles[i], image: images[i], index: i)
            labelViews.append(labelView)
        }
        for label in labelViews {
            scrollView.addSubview(label)
        }
        
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
    private func makeFrames() -> [CGRect] {
        var frames: [CGRect] = []
        
        if state == .horizontal {
            for i in 0..<animatedViews.count {
                let frame = CGRect(x: CGFloat(i) * bounds.width, y: 0, width: bounds.width, height: Settings.Sizes.middleSize)
                frames.append(frame)
            }
        } else {
            let vertical: CGFloat = Settings.menuItemsSpacing
            let w: CGFloat = self.bounds.width
            
            for i in 0..<animatedViews.count {
                let iterator: CGFloat = CGFloat(i)
                let tempIndex: CGFloat = CGFloat(currentIndex)
                let heightDiff = Settings.Sizes.middleSize - Settings.Sizes.menuItemsSize
                
                let frame = CGRect(x: w * iterator + progress * (w * tempIndex - w * iterator),
                                   y: (iterator * Settings.Sizes.menuItemsSize + iterator * CGFloat(vertical)) * progress,
                                   width: w,
                                   height: Settings.Sizes.middleSize - (heightDiff * progress))
                
                frames.append(frame)
                
                animatedViews[i].setState(progress: progress, state: state)
                labelViews[i].setState(progress: progress, state: state)
            }
        }
        
        return frames
    }
    
    func setScrollOffset() {
        let animatedView = animatedViews.filter({$0.index == Int(currentIndex)}).first
        
        let minY = CGFloat(currentIndex) * (Settings.Sizes.menuItemsSize + Settings.menuItemsSpacing)
        
        let diffX = scrollView.contentOffset.x - (animatedView?.frame.minX)!
        let diffY = min(minY, scrollView.contentSize.height - self.bounds.height)
        
        scrollView.contentOffset.x = (animatedView?.frame.minX)! - diffX * progress
        scrollView.contentOffset.y = diffY * progress
    }
    
    func setData(titles: [String], images: [UIImage]) {
        self.titles = titles
        self.images = images
        makeViews()
    }
    
    func updateHorizontalScrollInsets() {
        scrollView.contentInset = UIEdgeInsets(top: 0,
                                               left: -(animatedViews[currentIndex].frame.minX),
                                               bottom: 0,
                                               right: -(scrollView.contentSize.width - ((animatedViews.last?.frame.maxX)!)))
    }
    func updateVerticalScrollInsets() {
        scrollView.contentInset = UIEdgeInsets(top: 0,
                                               left: -(animatedViews[currentIndex].frame.minX),
                                               bottom: 0,
                                               right: -(scrollView.contentSize.width - ((animatedViews.last?.frame.maxX)!)))
    }
    
}

extension FulllscreenView: CellViewDelegate {
    
    func didTapCell(index: Int, cell: CellView) {
        self.delegate?.didTapCell(index: index)
    }
    
}

extension FulllscreenView: LabelViewDelegate {
    
    func didTapCell(index: Int, cell: LabelView) {
        self.delegate?.didTapCell(index: index)
    }
    
}
