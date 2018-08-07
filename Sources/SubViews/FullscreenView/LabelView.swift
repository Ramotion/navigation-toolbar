//
//  AnimatedView.swift
//  NavigationToolbar
//
//  Created by Artem P. on 22/05/2018.
//  Copyright © 2018 Ramotion. All rights reserved.
//

import UIKit

protocol LabelViewDelegate: class {
    func didTapCell(index: Int, cell: LabelView)
}

class LabelView: UIView {
    
    var label = Label.menuCellLabel()
    
    private var imageLeftOffsetMax: CGFloat = 100
    private var imageLeftOffsetCurrent: CGFloat = 0
    private var tapGest: UITapGestureRecognizer = UITapGestureRecognizer()
    
    private var progress: CGFloat = 0.0
    
    weak var delegate: LabelViewDelegate?
    
    var index: Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        self.backgroundColor = .clear
        
        self.clipsToBounds = false
        
        label.isHidden = false
        
        tapGest.addTarget(self, action: #selector(tapCell))
        self.addGestureRecognizer(tapGest)
        self.addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let w = self.bounds.width
        let h = self.bounds.height
        
        let half = w / 2 - label.intrinsicContentSize.width / 2
        
        label.frame = CGRect(x: half - (half - Settings.menuItemTextMargin) * progress,
                             y: 0,
                             width: label.intrinsicContentSize.width,
                             height: h)
    }
    
    @objc private func tapCell() {
        self.delegate?.didTapCell(index: index, cell: self)
    }
    
    func setData(title: String, image: UIImage, index: Int) {
        label.text = title
        self.index = index
    }
    
    func setState(progress: CGFloat, state: State) {
        imageLeftOffsetCurrent = imageLeftOffsetMax * progress
        self.progress = progress
        
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
}
