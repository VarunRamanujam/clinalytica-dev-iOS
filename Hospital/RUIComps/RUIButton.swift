//
//  RUIButton.swift
//  Hospital
//
//  Created by Shridhar on 1/31/17.
//
//

import UIKit

class RUIButton: UIButton {

    @IBInspectable var needBorderAndCornerRadius : Bool = false {
        didSet {
            if needBorderAndCornerRadius {
                self.addBorderAndCornerRadius()
            } else {
                self.removeBorderAndCornerRadius()
            }
        }
    }

}
