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
                                    NSFontAttributeName: UIFont.systemFont(ofSize: 20)]
    }
}
