//
//  View1.swift
//  Hospital
//
//  Created by Shridhar on 1/30/17.
//
//

import UIKit

class View1: UIView {

    @IBOutlet var label: UILabel!
    @IBOutlet var verticalStackView: UIStackView!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let view = UINib(nibName: "View1", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! UIView
        self.addSubview(view)
        
        installWrapContentLayoutConstraints(self, childView: view)
        
        label.text = "as,mc ashvcjvsa asvc sacj \n\n\nasdvjcshjv cskkc"
        
        for i in 0..<40 {
            let child = UILabel()
            child.text = "asdasdckascjsa\(i)"
            
            verticalStackView.addArrangedSubview(child)
        }
    }

}
