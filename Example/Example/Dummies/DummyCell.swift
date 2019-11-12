//
//  DummyView.swift
//  NavigationToolbar
//
//  Created by Artem P. on 22/05/2018.
//  Copyright © 2018 Ramotion. All rights reserved.
//

import UIKit

class DummyCell: UITableViewCell {

  private var avatarImageView = UIImageView()
  private var titleLabel = UILabel()
  private var subtitleLabel = UILabel()
  private var separatorView = UIView()
  private var contentImageView = UIImageView()
    
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
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
    titleLabel.text = title
    subtitleLabel.text = subtitle
    contentImageView.image = content
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    selectionStyle = .none
  }
}
