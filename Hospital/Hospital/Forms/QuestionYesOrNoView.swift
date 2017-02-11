//
//  QuestionYesOrNoView.swift
//  Hospital
//
//  Created by Shridhar on 2/3/17.
//
//

import UIKit
import BEMCheckBox

class QuestionYesOrNoView: RUIView {

    @IBOutlet var serialNumberLabel: RUILabel!
    @IBOutlet var titleLabel: RUILabel!
    @IBOutlet var yesOrNoStackView: RUIStackView!
    
    private var group = BEMCheckBoxGroup()
    
    var status : Bool? {
        set {
            if newValue == nil {
                group.selectedCheckBox = nil
            } else {
                if newValue == true {
                    group.selectedCheckBox = (yesOrNoStackView.arrangedSubviews[0] as? HorizontalOptionView)?.checkBox
                } else {
                    group.selectedCheckBox = (yesOrNoStackView.arrangedSubviews[1] as? HorizontalOptionView)?.checkBox
                }
            }
        }
        get {
            if group.selectedCheckBox == nil {
                return nil
            } else {
                if group.selectedCheckBox! == yesOrNoStackView.arrangedSubviews[0] {
                    return true
                } else {
                    return false
                }
            }
        }
    }
    
    var title : String! {
        didSet {
            titleLabel.text = title
        }
    }
    
    var serialNumber : Int! {
        didSet {
            serialNumberLabel.text = "\(serialNumber!)."
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initializeQuestionYesOrNoView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initializeQuestionYesOrNoView()
    }
    
    func initializeQuestionYesOrNoView() {
        let view = UINib(nibName: "QuestionYesOrNoView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! UIView
        
        self.addSubview(view)
        installWrapContentLayoutConstraints(self, childView: view)
        
        group.mustHaveSelection = true
        for view in yesOrNoStackView.arrangedSubviews as! [HorizontalOptionView] {
            group.addCheckBox(toGroup: view.checkBox!)
        }
    }

}
