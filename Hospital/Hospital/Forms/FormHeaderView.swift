//
//  FormHeaderView.swift
//  Hospital
//
//  Created by Shridhar on 2/1/17.
//
//

import UIKit

class FormHeaderView: RUIView {

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initializeFormHeaderView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initializeFormHeaderView()
    }
    
    func initializeFormHeaderView() {
        let view = UINib(nibName: "FormHeaderView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! UIView
        
        self.addSubview(view)
        installWrapContentLayoutConstraints(self, childView: view)
    }

}
