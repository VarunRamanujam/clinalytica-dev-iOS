//
//  PasscodeView.swift
//  Hospital
//
//  Created by Shridhar on 1/30/17.
//
//

import UIKit

class PasscodeView: UIView {

    var numberOfTextBoxes = 3
    var spacing : CGFloat = 10
    
    fileprivate var hiddenTextField : UITextField!
    fileprivate var stackView : UIStackView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initializePasscodeView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initializePasscodeView()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    fileprivate func initializePasscodeView() {
        hiddenTextField = UITextField(frame: self.bounds)
        hiddenTextField.isHidden = true
//        hiddenTextField.backgroundColor = UIColor.red
        self.addSubview(hiddenTextField)
        
        stackView = UIStackView(frame: self.bounds)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = spacing
        self.addSubview(stackView)
        
        for i in 0..<numberOfTextBoxes {
            let child = UITextField()
            child.backgroundColor = UIColor.lightGray
            child.tag = i+1
            child.delegate = self
            
            stackView.addArrangedSubview(child)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(PasscodeView.textFieldDidChange), name: NSNotification.Name.UITextFieldTextDidChange, object: nil)
    }
}


extension PasscodeView : UITextFieldDelegate {
    
    func textFieldDidChange(notification : Notification) {
        if let text = hiddenTextField.text {
            for i in 0..<numberOfTextBoxes {
                
                let child = stackView.arrangedSubviews[i] as! UITextField
                if i < text.length() {
                    let startIndex = text.index(text.startIndex, offsetBy: i)
                    let endIndex = text.index(text.startIndex, offsetBy: i)
                    
                    child.text = text[startIndex...endIndex]
                } else {
                    child.text = ""
                }
            }
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if hiddenTextField != textField {
            hiddenTextField.becomeFirstResponder()
            return false
        }
        return true
    }
    
    
}
