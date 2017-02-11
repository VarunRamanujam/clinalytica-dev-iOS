//
//  RUITextField.swift
//  Hospital
//
//  Created by Shridhar on 1/31/17.
//
//

import UIKit

class RUITextField: UITextField {

    
    @IBInspectable var needBorderAndCornerRadius : Bool = true {
        didSet {
            if needBorderAndCornerRadius {
                self.addBorderAndCornerRadius()
            } else {
                self.removeBorderAndCornerRadius()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initializeRUITextField()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initializeRUITextField()
    }
    
    func initializeRUITextField() {
        if needBorderAndCornerRadius {
            self.addBorderAndCornerRadius()
        } else {
            self.removeBorderAndCornerRadius()
        }
        
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: self.frame.height))
        leftView.backgroundColor = UIColor.clear
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: self.frame.height))
        rightView.backgroundColor = UIColor.clear
        
        self.leftView = leftView
        self.leftViewMode = .always
        self.rightView = rightView
        self.rightViewMode = .always
    }

}
