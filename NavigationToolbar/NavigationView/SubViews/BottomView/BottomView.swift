//
//  BottomView.swift
//  NavigationToolbar
//
//  Created by obozhdi on 22/05/2018.
//  Copyright © 2018 ramotion. All rights reserved.
//

extension UIView {
  
  func subViews<T : UIView>(type : T.Type) -> [T]{
    var all = [T]()
    for view in self.subviews {
      if let aView = view as? T{
        all.append(aView)
      }
    }
    return all
  }
  
  func allSubViewsOf<T : UIView>(type : T.Type) -> [T]{
    var all = [T]()
    func getSubview(view: UIView) {
      if let aView = view as? T{
        all.append(aView)
      }
      guard view.subviews.count>0 else { return }
      view.subviews.forEach{ getSubview(view: $0) }
    }
    getSubview(view: self)
    return all
  }
}

import UIKit

protocol BottomViewDelegate {
  func bottomDidScroll(offset: CGFloat)
}

class BottomView: UIView {
  
  private var scrollView  : UIScrollView       = UIScrollView()
  private var views: [UIView] = []
  
  var delegate: BottomViewDelegate?
  
  var isScrollingEnabled: Bool = true {
    didSet {
      scrollView.isScrollEnabled = isScrollingEnabled
    }
  }

  var canScroll: Bool = true {
    didSet {
      let needle = getRequiredView()

      needle.isScrollEnabled = canScroll
    }
  }
  
  var canScrollDown: Bool {
    get {
      let needle = getRequiredView()
      
      if needle.contentOffset.y <= 0 {
        return true
      }
      
      return false
    }
  }
  
  var currentOffset: CGFloat = 0.0 {
    didSet {
      self.scrollView.contentOffset.x = currentOffset
    }
  }
  
  var currentIndex: Int = 0

  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  private func getRequiredView() -> UIScrollView {
    let allSubviews = scrollView.allSubViewsOf(type: UIScrollView.self)
    
    var i = 0
    for view in allSubviews {
      if view.contentSize.width == bounds.width {
        let frame = (view.convert(view.frame, to: self))
        if frame.origin.x == 0 {
          return view
        }
        i += 1
      }
    }
    
    return UIScrollView()
  }
  
  private func setup() {
    scrollView.showsVerticalScrollIndicator   = false
    scrollView.showsHorizontalScrollIndicator = false
    scrollView.isPagingEnabled                = true
    scrollView.delegate                       = self
    
    addSubview(scrollView)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    scrollView.frame       = bounds
    scrollView.contentSize = CGSize(width : CGFloat(views.count) * bounds.width, height : bounds.height)
    
    var i: CGFloat = 0.0
    for view in views {
      view.frame = CGRect(x: i * bounds.width, y: 0, width: bounds.width, height: bounds.height)
      i += 1.0
    }
  }
  
  func setData(views: [UIView]) {
    self.views = views
    
    for view in self.views {
      scrollView.addSubview(view)
    }
    setNeedsLayout()
    layoutIfNeeded()
  }

}

extension BottomView: UIScrollViewDelegate {
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if scrollView == self.scrollView {
      delegate?.bottomDidScroll(offset: scrollView.contentOffset.x)
    }
  }
  
}
