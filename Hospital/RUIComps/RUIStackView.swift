//
//  RUIStackView.swift
//  Hospital
//
//  Created by Shridhar on 2/1/17.
//
//

import UIKit

class RUIStackView: UIStackView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
}
