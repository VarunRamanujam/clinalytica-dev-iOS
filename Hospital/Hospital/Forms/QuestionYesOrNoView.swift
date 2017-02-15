//
//  QuestionYesOrNoView.swift
//  Hospital
//
//  Created by Shridhar on 2/3/17.
//
//

import UIKit
import BEMCheckBox

class QuestionYesOrNoView: RUIView, HorizontalOptionViewDelegate {

    @IBOutlet var serialNumberLabel: RUILabel!
    @IBOutlet var titleLabel: RUILabel!
    @IBOutlet var yesOrNoStackView: RUIStackView!
    
    private var group = BEMCheckBoxGroup()
    
    private var status : Bool?
    
    func getStausValue() -> Bool? {
        return status
    }
    
    func setStausValue(value : Bool?) {
        status = value
        if value == nil {
            group.selectedCheckBox = nil
        } else {
            if value == true {
                group.selectedCheckBox = (yesOrNoStackView.arrangedSubviews[0] as? HorizontalOptionView)?.checkBox
            } else {
                group.selectedCheckBox = (yesOrNoStackView.arrangedSubviews[1] as? HorizontalOptionView)?.checkBox
            }
        }
    }
    
    func unSelectOptions() {
        group.selectedCheckBox?.on = false
        status = nil
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
            view.delegate = self
            group.addCheckBox(toGroup: view.checkBox!)
        }
    }
    
    func didTap(sender: HorizontalOptionView, selected: Bool) {
        let views = yesOrNoStackView.arrangedSubviews as! [HorizontalOptionView]
        if views[0] == sender {
            status = true
        } else {
            status = false
        }
    }
}
