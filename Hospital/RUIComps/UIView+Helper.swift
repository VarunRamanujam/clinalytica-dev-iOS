//
//  UIView+VIY.swift
//  VIY
//
//  Created by Shridhar on 5/20/16.
//  Copyright © 2016 costrategix. All rights reserved.
//

import UIKit

//@IBDesignable
extension UIView {
    
    func addBorderAndCornerRadius() {
        addBorder()
        addCornerRadius()
    }
    
    func removeBorderAndCornerRadius() {
        removeBorder()
        removeCornerRadius()
    }
    
    func addBorder() {
        self.layer.borderWidth = 2.0
        self.layer.borderColor = UIColor(red: 216, green: 225, blue: 229).cgColor
    }
    
    func removeBorder() {
        self.layer.borderWidth = 0.0
    }
    
    func addCornerRadius() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 5.0
    }
    
    func removeCornerRadius() {
        self.layer.cornerRadius = 0.0
    }
    
    func makeCircle() {
        self.layer.cornerRadius = self.frame.width * 0.5
    }
}
