//
//  HorizontalOptionView.swift
//  Hospital
//
//  Created by Shridhar on 2/1/17.
//
//

import UIKit
import BEMCheckBox

protocol HorizontalOptionViewDelegate : class {
    func didTap(sender : HorizontalOptionView, selected : Bool)
}

class HorizontalOptionView: RUIStackView {

    weak var delegate : HorizontalOptionViewDelegate?
    
    @IBInspectable var boxTypeInteger : Int = BEMBoxType.square.rawValue {
        didSet {
            boxType = BEMBoxType(rawValue: boxTypeInteger)!
        }
    }
    
    
    var boxType = BEMBoxType.square {
        didSet {
            updateCheckboxType()
        }
    }
    
    @IBInspectable var title : String! {
        didSet {
            titleLabel?.text = title
        }
    }
    
    @IBInspectable var selected = false {
        didSet {
            updateCheckBoxValue()
        }
    }
    
    var checkBox : BEMCheckBox?
    private var titleLabel : RUILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initializeHorizontalOptionView()
    }
    
    init(frame: CGRect, boxType : BEMBoxType) {
        super.init(frame: frame)
        self.boxType = boxType
        
        initializeHorizontalOptionView()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initializeHorizontalOptionView()
    }
    
    private func initializeHorizontalOptionView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.axis = .horizontal
        self.distribution = .fillProportionally
        self.alignment = .center
        self.spacing = 15
        
        checkBox = BEMCheckBox(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        checkBox?.lineWidth = 2.0
        checkBox?.delegate = self
        updateCheckboxType()
        self.addArrangedSubview(checkBox!)
        checkBox?.addConstraint(NSLayoutConstraint(item: checkBox!,
                                                  attribute: NSLayoutAttribute.width,
                                                  relatedBy: NSLayoutRelation.equal,
                                                  toItem: nil,
                                                  attribute: NSLayoutAttribute.notAnAttribute,
                                                  multiplier: 1.0, constant: 50))
        checkBox?.addConstraint(NSLayoutConstraint(item: checkBox!,
                                                  attribute: NSLayoutAttribute.height,
                                                  relatedBy: NSLayoutRelation.equal,
                                                  toItem: nil,
                                                  attribute: NSLayoutAttribute.notAnAttribute,
                                                  multiplier: 1.0, constant: 50))
        
        titleLabel = RUILabel()
        titleLabel?.textAlignment = .justified
        titleLabel?.font = UIFont.systemFont(ofSize: 24)
        titleLabel?.numberOfLines = 0
        titleLabel?.text = title
        
        
        self.addArrangedSubview(titleLabel!)
        
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(HorizontalOptionView.didTap as (HorizontalOptionView) -> () -> ())))
    }
    
    func updateCheckboxType() {
        checkBox?.boxType = boxType
        
        if boxType == .square {
            checkBox?.onAnimationType = .bounce
            checkBox?.offAnimationType = .bounce
            
            checkBox?.onTintColor = UIColor(red: 181, green: 200, blue: 209)//Line-On
            checkBox?.tintColor = UIColor(red: 181, green: 200, blue: 209)//Line-Off
            checkBox?.onCheckColor = UIColor(red: 72, green: 194, blue: 64)
            checkBox?.onFillColor = UIColor.white
            checkBox?.offFillColor = UIColor.white
            
        } else {
            checkBox?.onAnimationType = .fade
            checkBox?.offAnimationType = .fade
            
            checkBox?.onTintColor = UIColor(red: 181, green: 200, blue: 209)//Line-On
            checkBox?.tintColor = UIColor(red: 181, green: 200, blue: 209)//Line-Off
            checkBox?.onCheckColor = UIColor(red: 72, green: 194, blue: 64)
            checkBox?.onFillColor = UIColor(red: 72, green: 194, blue: 64)
            checkBox?.offFillColor = UIColor.white
        }
    }
    
    func didTap() {
        if selected {
            return
        }
        checkBox?.setOn(!selected, animated: true)
        
        delegate?.didTap(sender: self, selected: !selected)
    }
    
    private func updateCheckBoxValue() {
        checkBox?.on = selected
    }
}

extension HorizontalOptionView : BEMCheckBoxDelegate {
    func didTap(_ checkBox: BEMCheckBox) {
        delegate?.didTap(sender: self, selected: checkBox.on)
    }
    
    func animationDidStop(for checkBox: BEMCheckBox) {
        selected = !selected
    }
}
