//
//  MedicalHistoryAndStatusCell.swift
//  Hospital
//
//  Created by Shridhar on 2/3/17.
//
//

import UIKit
import BEMCheckBox

class MedicalHistoryAndStatusCell: RUITableViewCell, BEMCheckBoxDelegate {

    @IBOutlet var titleLabel: RUILabel!
    @IBOutlet var yesCheckBox: BEMCheckBox!
    @IBOutlet var noCheckBox: BEMCheckBox!
    @IBOutlet var textField: RUITextField!
    
    var checkBoxGroup = BEMCheckBoxGroup()
    
    var medicalHistoryData : MedicalHistory! {
        didSet {
            updatedData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        yesCheckBox.on = false
        noCheckBox.on = false
        
        yesCheckBox.delegate = self
        noCheckBox.delegate = self
        
        checkBoxGroup.mustHaveSelection = true
        checkBoxGroup.addCheckBox(toGroup: yesCheckBox)
        checkBoxGroup.addCheckBox(toGroup: noCheckBox)
        
        NotificationCenter.default.addObserver(self, selector: #selector(MedicalHistoryAndStatusCell.textFieldTextDidChange(sender:)), name: NSNotification.Name.UITextFieldTextDidChange, object: textField)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updatedData() {
        textField.isHidden = true
        yesCheckBox.on = false
        noCheckBox.on = false
        
        titleLabel.text = medicalHistoryData.title
        
        if medicalHistoryData.status == nil {
            yesCheckBox.on = false
            noCheckBox.on = false
        } else {
            if medicalHistoryData.status == 1 {
                yesCheckBox.on = true
                noCheckBox.on = false
                textField.isHidden = false
                textField.text = medicalHistoryData.medicalDescription
            } else {
                yesCheckBox.on = false
                noCheckBox.on = true
            }
        }
    }
    
    func didTap(_ checkBox: BEMCheckBox) {
        if checkBox.on {
            if yesCheckBox == checkBox {
                medicalHistoryData.status = 1
                textField.isHidden = false
            } else {
                medicalHistoryData.status = 2
                textField.isHidden = true
            }
        }
    }
    
    func textFieldTextDidChange(sender : Notification) {
        medicalHistoryData.medicalDescription = textField.text
    }
}

//MARK:- UITextFieldDelegate
extension MedicalHistoryAndStatusCell : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let newStr = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
        if newStr.length() > Text_Length {
            return false
        }
        return true
    }
}
