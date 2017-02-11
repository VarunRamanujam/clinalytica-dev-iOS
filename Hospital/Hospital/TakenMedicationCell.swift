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
            medication.startDate = newDate
        } else if stopDate == sender {
            medication.stopDate = newDate
        }
    }
    
    func didTap(_ checkBox: BEMCheckBox) {
        medication.continueing = checkBox.on
    }
}

//MARK:- Private Methods
extension TakenMedicationCell {
    func initializeMedicationCell() {
        startDate.delegate = self
        stopDate.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(TakenMedicationCell.drugNameTextDidChange(sender:)), name: NSNotification.Name.UITextFieldTextDidChange, object: drugNameTF)
        NotificationCenter.default.addObserver(self, selector: #selector(TakenMedicationCell.codeDrugTextDidChange(sender:)), name: NSNotification.Name.UITextFieldTextDidChange, object: drugNameTF)
        NotificationCenter.default.addObserver(self, selector: #selector(TakenMedicationCell.strengthTextDidChange(sender:)), name: NSNotification.Name.UITextFieldTextDidChange, object: drugNameTF)
        NotificationCenter.default.addObserver(self, selector: #selector(TakenMedicationCell.dosesPerDayTextDidChange(sender:)), name: NSNotification.Name.UITextFieldTextDidChange, object: drugNameTF)
        NotificationCenter.default.addObserver(self, selector: #selector(TakenMedicationCell.codeIndicationTextDidChange(sender:)), name: NSNotification.Name.UITextFieldTextDidChange, object: drugNameTF)
        
        continueingCheckBox.delegate = self
    }
    
    func updatedData() {
        drugNameTF.text = medication.drugName
        codeDrugTF.text = medication.drugCode
        strengthTF.text = medication.strength
        dosesPerDayTF.text = medication.dosesPerDay
        codeIndicationTF.text = medication.codeIndication
        
        startDate.date = medication.startDate
        stopDate.date = medication.stopDate
        continueingCheckBox.on = medication.continueing ?? false
    }
    
    func drugNameTextDidChange(sender : Notification) {
        medication.drugName = drugNameTF.text
    }
    
    func codeDrugTextDidChange(sender : Notification) {
        medication.drugCode = codeDrugTF.text
    }
    
    func strengthTextDidChange(sender : Notification) {
        medication.strength = strengthTF.text
    }
    
    func dosesPerDayTextDidChange(sender : Notification) {
        medication.dosesPerDay = dosesPerDayTF.text
    }
    
    func codeIndicationTextDidChange(sender : Notification) {
        medication.codeIndication = codeIndicationTF.text
    }
}
