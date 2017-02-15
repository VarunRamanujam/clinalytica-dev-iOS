//
//  FormHeaderView.swift
//  Hospital
//
//  Created by Shridhar on 2/1/17.
//
//

import UIKit

class FormHeaderInfo: NSObject {
    var patient_initials : String!
    var study   : String!
    var form_no : Int!
    var center  : Int!
    var patient_number : Int!
    var vst_date: Date!
    
    static let shared = FormHeaderInfo()
}

class FormHeaderView: RUIView, UITextFieldDelegate, DateViewDelegate {
    @IBOutlet var patientInitials: RUITextField!
    @IBOutlet var studyInitials: RUITextField!
    @IBOutlet var formNumberTF: RUITextField!
    @IBOutlet var centerNumberTF: RUITextField!
    @IBOutlet var patientNumber: RUITextField!
    @IBOutlet var dateOfVisit: DateView!
    
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
        
        
        dateOfVisit.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(FormHeaderView.patientInitialsTextDidChange(notification:)), name: NSNotification.Name.UITextFieldTextDidChange, object: patientInitials)
        NotificationCenter.default.addObserver(self, selector: #selector(FormHeaderView.studyInitialsTextDidChange(notification:)), name: NSNotification.Name.UITextFieldTextDidChange, object: studyInitials)
        NotificationCenter.default.addObserver(self, selector: #selector(FormHeaderView.formNumberTextDidChange(notification:)), name: NSNotification.Name.UITextFieldTextDidChange, object: formNumberTF)
        NotificationCenter.default.addObserver(self, selector: #selector(FormHeaderView.centerNumberTFTextDidChange(notification:)), name: NSNotification.Name.UITextFieldTextDidChange, object: centerNumberTF)
        NotificationCenter.default.addObserver(self, selector: #selector(FormHeaderView.patientNumberTextDidChange(notification:)), name: NSNotification.Name.UITextFieldTextDidChange, object: patientNumber)
    }

    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let newStr = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
        
        if textField == formNumberTF {
            if newStr.length() > Form_Number_Length {
                return false
            }
            return newStr.canStringBeNumber()
            
        } else if textField == studyInitials {
            
            return newStr.length() <= Study_Length
            
        } else if textField == centerNumberTF {
           
            if newStr.length() > Center_Length {
                return false
            }
            return newStr.canStringBeNumber()
            
        } else if textField == patientNumber {
            
            if newStr.length() > Patient_Number_Length {
                return false
            }
            return newStr.canStringBeNumber()
        }
        
        return true
    }
    
    func dateChanged(sender: DateView, newDate: Date) {
        FormHeaderInfo.shared.vst_date = newDate
    }
    
    func patientInitialsTextDidChange(notification : Notification) {
        FormHeaderInfo.shared.patient_initials = patientInitials.text
    }
    
    func studyInitialsTextDidChange(notification : Notification) {
        FormHeaderInfo.shared.study = studyInitials.text
    }
    
    func formNumberTextDidChange(notification : Notification) {
        FormHeaderInfo.shared.form_no = formNumberTF.text?.toInt()
    }
    
    func centerNumberTFTextDidChange(notification : Notification) {
        FormHeaderInfo.shared.center = centerNumberTF.text?.toInt()
    }
    
    func patientNumberTextDidChange(notification : Notification) {
        FormHeaderInfo.shared.patient_number = patientNumber.text?.toInt()
    }
}
