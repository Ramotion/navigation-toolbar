//
//  GesturedScrollView.swift
//  Navigation-toolbar
//
//  Created by obozhdi on 11/04/2018.
//  Copyright © 2018 obozhdi. All rights reserved.
//

import UIKit

class GesturedScrollView: UIScrollView {

  func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                         shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    return true
  }
  
}
