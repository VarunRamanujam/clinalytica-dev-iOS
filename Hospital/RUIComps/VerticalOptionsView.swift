//
//  OptionsView.swift
//  Hospital
//
//  Created by Shridhar on 2/1/17.
//
//

import UIKit
import BEMCheckBox

class VerticalOptionsView: UIView, HorizontalOptionViewDelegate {

    private var stackView : RUIStackView!
    let group = BEMCheckBoxGroup()
    
    var titels : [String]! {
        didSet {
            updateViews()
        }
    }
    
    var singleSelection = true
    
    func deselectAllSelctions() {
        selectedIndex = nil
        group.selectedCheckBox?.on = false
        for view in stackView.arrangedSubviews as! [HorizontalOptionView] {
            view.selected = false
        }
    }
    
    private var selectedIndex : Int?
    
    func setSelectedIndexValue(value : Int?) {
        selectedIndex = value
        
        group.selectedCheckBox?.on = false
        for view in stackView.arrangedSubviews as! [HorizontalOptionView] {
            view.selected = false
        }
        
        if selectedIndex != nil {
            let horizontalView = (stackView.arrangedSubviews as! [HorizontalOptionView])[selectedIndex!]
            horizontalView.selected = true
            group.selectedCheckBox = horizontalView.checkBox
        }
        
    }
    
    func getSelectedIndexValue() -> Int? {
        return selectedIndex
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initializeVerticalOptionsView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initializeVerticalOptionsView()
    }
    
    private func initializeVerticalOptionsView() {
        stackView = RUIStackView(frame: self.bounds)
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.spacing = 10
        self.addSubview(stackView)
        
        installWrapContentLayoutConstraints(self, childView: stackView)
        
        titels = ["2017-02-01 12:38:20.467423 Hospital[4402:64893] [Application] Failed to instantiate the default view controller for UIMainStoryboardFile 'Main' - perhaps the designated entry point is not set? 2017-02-01 12:38:20.467423 Hospital[4402:64893] [Application] Failed to instantiate the default view controller for UIMainStoryboardFile 'Main' - perhaps the designated entry point is not set?", "White", "Green"]
    }
    
    private func updateViews() {
        
        self.group.mustHaveSelection = true;
        
        for view in stackView.arrangedSubviews {
            let optionView = view as! HorizontalOptionView
            stackView.removeArrangedSubview(optionView)
            group.removeCheckBox(fromGroup: optionView.checkBox!)
            optionView.removeFromSuperview()
        }
        
        for i in 0..<titels.count {
            let optionView = HorizontalOptionView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 30))
            optionView.delegate = self
            optionView.title = titels[i]
            optionView.selected = false
            stackView.addArrangedSubview(optionView)
            
            group.addCheckBox(toGroup: optionView.checkBox!)
        }
    }

    func didTap(sender: HorizontalOptionView, selected: Bool) {
        selectedIndex = stackView.arrangedSubviews.index(of: sender)
    }
}
