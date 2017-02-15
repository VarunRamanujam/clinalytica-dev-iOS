//
//  VIYNavigationBar.swift
//  VIY
//
//  Created by Shridhar on 5/18/16.
//  Copyright © 2016 costrategix. All rights reserved.
//

import UIKit

//@IBDesignable
class RUINavigationBar: UINavigationBar {
    
    let bottomBorder = CALayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initializeVIYNavigationBar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initializeVIYNavigationBar()
    }
    
    func initializeVIYNavigationBar()  {
        self.setBackgroundImage(UIImage(), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
        self.shadowImage = UIImage()
        
        self.isTranslucent = false
        
        self.barTintColor = UIColor(red: 250, green: 251, blue: 253)
        self.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.black,
                                    NSFontAttributeName: UIFont.boldSystemFont(ofSize: 22.0)]
        
        self.layer.addSublayer(bottomBorder)
        bottomBorder.backgroundColor = UIColor(red: 216, green: 225, blue: 229).cgColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        bottomBorder.frame = CGRect(x: 0, y: self.frame.height - 2, width: self.frame.width, height: 2.0)
    }
}
