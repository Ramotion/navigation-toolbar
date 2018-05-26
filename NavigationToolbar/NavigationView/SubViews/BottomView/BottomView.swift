//
//  BottomView.swift
//  NavigationToolbar
//
//  Created by obozhdi on 22/05/2018.
//  Copyright © 2018 ramotion. All rights reserved.
//

extension UIView {
  
  /** This is the function to get subViews of a view of a particular type
   */
  func subViews<T : UIView>(type : T.Type) -> [T]{
    var all = [T]()
    for view in self.subviews {
      if let aView = view as? T{
        all.append(aView)
      }
    }
    return all
  }
  
  
  /** This is a function to get subViews of a particular type from view recursively. It would look recursively in all subviews and return back the subviews of the type T */
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

class BottomView: UIView {
  
  private var scrollView  : UIScrollView       = UIScrollView()
  private var views: [UIView] = []
  
  var shouldBlockPan: Bool {
    get {
      let needle = getRequiredView()
      
      if needle.contentOffset.y <= 0 {
        return false
      }
      
      return true
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
        print("===========")
        print(i)
        print(view.contentSize)
        print(view.frame.origin)
        let frame = (view.convert(view.frame, to: self))
        print(frame)
        if frame.origin.x == 0 {
          return view
        }
        print("-----------")
        i += 1
      }
    }
    
    return UIScrollView()
  }
  
  private func setup() {
    scrollView.showsVerticalScrollIndicator   = false
    scrollView.showsHorizontalScrollIndicator = false
    scrollView.isPagingEnabled                = true
    
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
