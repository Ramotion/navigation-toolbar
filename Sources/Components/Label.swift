//
//  Label.swift
//  NavigationToolbar
//
//  Created by Artem P. on 22/05/2018.
//  Copyright © 2018 Ramotion. All rights reserved.
//

import UIKit

class Label: UILabel {
    
    class func topViewCellLabel() -> UILabel {
        let label = UILabel()
        label.clipsToBounds = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: Settings.Sizes.labelFontSize)
        label.textAlignment = .center
        
        return label
    }
    
    class func sideLabel() -> UILabel {
        let label = UILabel()
        label.clipsToBounds = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: Settings.Sizes.labelFontSize)
        label.textAlignment = .center
        
        return label
    }
    
    class func menuCellLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .left
        label.clipsToBounds = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: Settings.Sizes.labelFontSize)
        
        return label
    }
    
}
