//
//  RUITextView.swift
//  Hospital
//
//  Created by Shridhar on 1/31/17.
//
//

import UIKit

class RUITextView: UITextView {

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        initializeRUITextView()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initializeRUITextView()
    }
    
    func initializeRUITextView() {
        self.addBorderAndCornerRadius()
    }
}
