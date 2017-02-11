//
//  View2.swift
//  Hospital
//
//  Created by Shridhar on 1/30/17.
//
//

import UIKit

class View2: UIView {

    @IBOutlet var label: UILabel!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let view = UINib(nibName: "View2", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! UIView
        self.addSubview(view)
        
        
        installWrapContentLayoutConstraints(self, childView: view)
        
        label.text = "\t as,mc ashvcjvsa asvc sacj asdvjcshjv cskkc\nasvhajva asdas as da sd asdasdaasa\n\n\n\n\n aksvcjasvcjvasjh"
    }
}
