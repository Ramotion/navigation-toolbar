//
//  DummyView.swift
//  NavigationToolbar
//
//  Created by obozhdi on 22/05/2018.
//  Copyright © 2018 ramotion. All rights reserved.
//

import UIKit

class DummyCell: UITableViewCell {
  
  var label = UILabel()
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  private func setup() {
    label.text = "SOME_TEXT"
    label.textAlignment = .center
    label.textColor = .red
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    label.frame = CGRect(x: 0, y: 0, width: 200, height: 30)
  }
  
}

class DummyView: UIView {
  
  private var tableView = UITableView()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  private func setup() {
    backgroundColor = UIColor.black
    
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(DummyCell.self, forCellReuseIdentifier: "DummyCell")
    
    addSubview(tableView)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    tableView.frame = bounds
  }

}

extension DummyView: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 100
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "DummyCell", for: indexPath) as! DummyCell
    cell.label.text = "\(indexPath.row)"
    return cell
  }
  
}

extension DummyView: UIScrollViewDelegate {
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    print("OFFSET \(scrollView.contentOffset.y)")
//    if scrollView.contentOffset.y < 0  {
//      tableView.isUserInteractionEnabled = false
//    } else {
//      tableView.isUserInteractionEnabled = true
//    }
  }
  
}
