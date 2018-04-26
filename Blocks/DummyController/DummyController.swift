//
//  Copyright © 2018 Ramotion. All rights reserved.
//

import UIKit

class DummyController: UIViewController {
  
  private var tableView: UITableView = UITableView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .green
    
    tableView.frame      = view.bounds
    tableView.delegate   = self
    tableView.dataSource = self
//    view.addSubview(tableView)
    
    tableView.register(DummyCell.self, forCellReuseIdentifier: "Cell")
    
    view.backgroundColor = getRandomColor()
  }
  
  private func getRandomColor() -> UIColor {
    let randomRed   :CGFloat = CGFloat(drand48())
    let randomGreen :CGFloat = CGFloat(drand48())
    let randomBlue  :CGFloat = CGFloat(drand48())
    
    return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
  }
  
}

extension DummyController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 42
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! DummyCell
    
    cell.textLabel?.text = "\(indexPath.row)"
    cell.detailTextLabel?.text = "\(indexPath.row)"
    
    return cell
  }
  
}
