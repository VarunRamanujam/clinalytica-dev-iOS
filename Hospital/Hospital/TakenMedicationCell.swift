//
//  TakenMedicationCell.swift
//  Hospital
//
//  Created by Shridhar on 2/5/17.
//
//

import UIKit
import BEMCheckBox

class TakenMedicationCell: RUITableViewCell, DateViewDelegate, BEMCheckBoxDelegate {

    @IBOutlet var drugNameTF: RUITextField!
    @IBOutlet var codeDrugTF: RUITextField!
    @IBOutlet var strengthTF: RUITextField!
    @IBOutlet var dosesPerDayTF: RUITextField!
    @IBOutlet var codeIndicationTF: RUITextField!
    @IBOutlet var startDate: DateView!
    @IBOutlet var stopDate: DateView!
    @IBOutlet var continueingCheckBox: BEMCheckBox!
    
    var medication : Medication! {
        didSet {
            updatedData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        initializeMedicationCell()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func dateChanged(sender: DateView, newDate: Date) {
        if startDate == sender {
            medication.startDate = newDate.getString()
        } else if stopDate == sender {
            medication.stopDate = newDate.getString()
        }
    }
    
    func didTap(_ checkBox: BEMCheckBox) {
        medication.continueing = checkBox.on ? 2 : 1
    }
}

//MARK:- UITextFieldDelegate
extension TakenMedicationCell : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let newStr = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
        if textField == drugNameTF {
            if newStr.length() > Text_Length {
                return false
            }
            return false
        } else if textField == codeDrugTF {
            if newStr.length() > Code_Drug_Length {
                return false
            }
            return true
        } else if textField == strengthTF {
            if newStr.length() > Strength_Length {
                return false
            }
            return newStr.canStringBeNumber()
        } else if textField == dosesPerDayTF {
            if newStr.length() > Doses_Per_Day_Length {
                return false
            }
            return newStr.canStringBeNumber()
        } else if textField == codeIndicationTF {
            if newStr.length() > Code_Indication_Length {
                return false
            }
            return newStr.canStringBeNumber()
        }
        
        return true
    }
}

//MARK:- Private Methods
extension TakenMedicationCell {
    func initializeMedicationCell() {
        drugNameTF.delegate = self
        codeDrugTF.delegate = self
        strengthTF.delegate = self
        dosesPerDayTF.delegate = self
        codeIndicationTF.delegate = self
        startDate.delegate = self
        stopDate.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(TakenMedicationCell.drugNameTextDidChange(sender:)), name: NSNotification.Name.UITextFieldTextDidChange, object: drugNameTF)
        NotificationCenter.default.addObserver(self, selector: #selector(TakenMedicationCell.codeDrugTextDidChange(sender:)), name: NSNotification.Name.UITextFieldTextDidChange, object: codeDrugTF)
        NotificationCenter.default.addObserver(self, selector: #selector(TakenMedicationCell.strengthTextDidChange(sender:)), name: NSNotification.Name.UITextFieldTextDidChange, object: strengthTF)
        NotificationCenter.default.addObserver(self, selector: #selector(TakenMedicationCell.dosesPerDayTextDidChange(sender:)), name: NSNotification.Name.UITextFieldTextDidChange, object: dosesPerDayTF)
        NotificationCenter.default.addObserver(self, selector: #selector(TakenMedicationCell.codeIndicationTextDidChange(sender:)), name: NSNotification.Name.UITextFieldTextDidChange, object: codeIndicationTF)
        
        continueingCheckBox.delegate = self
    }
    
    func updatedData() {
        drugNameTF.text = medication.drugName
        codeDrugTF.text = medication.drugCode
        strengthTF.text = medication.strength != nil ? "\(medication.strength)" : ""
        dosesPerDayTF.text = medication.dosesPerDay != nil ? "\(medication.dosesPerDay)" : ""
        codeIndicationTF.text = medication.codeIndication != nil ? "\(medication.codeIndication)" : ""
        
        startDate.date = Date.getDate(str: medication.startDate)
        stopDate.date = Date.getDate(str: medication.stopDate)
        if medication.continueing != nil && medication.continueing == 2 {
            continueingCheckBox.on = true
        } else {
            continueingCheckBox.on = false
        }
        
    }
    
    func drugNameTextDidChange(sender : Notification) {
        medication.drugName = drugNameTF.text
    }
    
    func codeDrugTextDidChange(sender : Notification) {
        medication.drugCode = codeDrugTF.text
    }
    
    func strengthTextDidChange(sender : Notification) {
        medication.strength = strengthTF.text?.toInt()
    }
    
    func dosesPerDayTextDidChange(sender : Notification) {
        medication.dosesPerDay = dosesPerDayTF.text?.toInt()
    }
    
    func codeIndicationTextDidChange(sender : Notification) {
        medication.codeIndication = codeIndicationTF.text?.toInt()
    }
}
