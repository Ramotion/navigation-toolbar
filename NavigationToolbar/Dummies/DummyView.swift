//
//  DummyView.swift
//  NavigationToolbar
//
//  Created by obozhdi on 22/05/2018.
//  Copyright © 2018 ramotion. All rights reserved.
//

import UIKit

class DummyCell: UITableViewCell {
  
  private var avatarImageView  : UIImageView = UIImageView()
  private var titleLabel       : UILabel     = UILabel()
  private var subtitleLabel    : UILabel     = UILabel()
  private var separatorView    : UIView      = UIView()
  private var contentImageView : UIImageView = UIImageView()
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  override func awakeFromNib() {
    
  }
  
  private func setup() {
    avatarImageView.contentMode = .scaleAspectFill
    avatarImageView.clipsToBounds = true
    avatarImageView.layer.cornerRadius = 4.0
    
    contentImageView.contentMode = .scaleAspectFill
    contentImageView.clipsToBounds = true
    contentImageView.layer.cornerRadius = 4.0
    
    titleLabel.font = UIFont.systemFont(ofSize: 15)
    titleLabel.textColor = UIColor.darkText
    
    subtitleLabel.font = UIFont.systemFont(ofSize: 13)
    subtitleLabel.textColor = UIColor.gray
    
    separatorView.backgroundColor = UIColor.gray
    separatorView.alpha = 0.5
    
    addSubview(avatarImageView)
    addSubview(titleLabel)
    addSubview(subtitleLabel)
    addSubview(separatorView)
    addSubview(contentImageView)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    let w = bounds.width
    
    avatarImageView.frame = CGRect(x: 16, y: 16, width: 40, height: 40)
    titleLabel.frame = CGRect(x: avatarImageView.frame.maxX + 16, y: 16, width: w - 40 - 48, height: 20)
    subtitleLabel.frame = CGRect(x: avatarImageView.frame.maxX + 16, y: titleLabel.frame.maxY, width: w - 40 - 48, height: 20)
    separatorView.frame = CGRect(x: 16, y: avatarImageView.frame.maxY + 16, width: w - 32, height: 0.5)
    contentImageView.frame = CGRect(x: 16, y: separatorView.frame.maxY + 8, width: w - 32, height: 250)
  }
  
  func setData(avatar: UIImage, title: String, subtitle: String, content: UIImage) {
    avatarImageView.image  = avatar
    titleLabel.text        = title
    subtitleLabel.text     = subtitle
    contentImageView.image = content
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    selectionStyle = .none
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
    tableView.separatorColor = .clear
    
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
    cell.setData(avatar: UIImage(named: "image14")!, title: "Jellyfish Cam offers Stunning Views", subtitle: "3k views • 5 days ago", content: UIImage(named: "image13")!)
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 350
  }
  
}

extension DummyView: UIScrollViewDelegate {
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    
  }
  
}
