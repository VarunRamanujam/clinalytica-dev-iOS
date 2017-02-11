//
//  MedicalStatusCell.swift
//  Hospital
//
//  Created by Shridhar on 2/4/17.
//
//

import UIKit

class MedicalStatusCell: RUITableViewCell, DateViewDelegate, OptionsPopOverViewControllerDelegate {

    @IBOutlet var natureOfProblemTF: RUITextField!
    @IBOutlet var medicalEventCodeTF: RUITextField!
    @IBOutlet var dateOfOnset: DateView!
    @IBOutlet var severityButton: RUIButton!
    @IBOutlet var actionTakenButton: RUIButton!
    
    var medicalStatus : MedicalStatus! {
        didSet {
            updatedData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        initializeMedicalStatusCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func dateChanged(sender: DateView, newDate: Date) {
        medicalStatus.dateOfOnSet = newDate
    }
    
    func didSelectOption(sender: OptionsPopOverViewController, index: Int, title: String) {
        if sender.popoverPresentationController?.sourceView == severityButton {
            severityButton.setTitle("\(index + 1)", for: UIControlState.normal)
        } else if sender.popoverPresentationController?.sourceView == actionTakenButton {
            actionTakenButton.setTitle("\(index + 1)", for: UIControlState.normal)
        }
    }
    
    @IBAction func severityButtonClicked(_ sender: RUIButton) {
        presentOptionsViewCntl(options: SeverityOptions, view: sender, size: CGSize(width: 250, height: 220), title: "Severity")
    }
    
    @IBAction func ActionTakenButtonClicked(_ sender: RUIButton) {
        presentOptionsViewCntl(options: ActionTakenOptions, view: sender, size: CGSize(width: 350, height: 350), title: "Action Taken")
    }
    
}

//MARK:- Private Methods
extension MedicalStatusCell {
    func initializeMedicalStatusCell() {
        dateOfOnset.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(MedicalStatusCell.natureOfProblemTextDidChange(sender:)), name: NSNotification.Name.UITextFieldTextDidChange, object: natureOfProblemTF)
        NotificationCenter.default.addObserver(self, selector: #selector(MedicalStatusCell.medicalEventCodeTextDidChange(sender:)), name: NSNotification.Name.UITextFieldTextDidChange, object: medicalEventCodeTF)
    }
    
    func updatedData() {
        natureOfProblemTF.text = medicalStatus.natureOfProblem
        medicalEventCodeTF.text = medicalStatus.eventCode
        dateOfOnset.date = medicalStatus.dateOfOnSet
        
        if medicalStatus.severity != nil {
            severityButton.setTitle("\(medicalStatus.severity!)", for: UIControlState.normal)
        } else {
            severityButton.setTitle("", for: UIControlState.normal)
        }
        
        if medicalStatus.ationTaken != nil {
            actionTakenButton.setTitle("\(medicalStatus.ationTaken!)", for: UIControlState.normal)
        } else {
            actionTakenButton.setTitle("", for: UIControlState.normal)
        }
        
    }
    
    func natureOfProblemTextDidChange(sender : Notification) {
        medicalStatus.natureOfProblem = natureOfProblemTF.text
    }
    
    func medicalEventCodeTextDidChange(sender : Notification) {
        medicalStatus.eventCode = medicalEventCodeTF.text
    }
    
    func presentOptionsViewCntl(options : [String], view : UIView, size : CGSize, title : String) {
        let severityVC = OptionsPopOverViewController(nibName: "OptionsPopOverViewController", bundle: nil)
        severityVC.options = options
        severityVC.delegate = self
        severityVC.title = title
        severityVC.preferredContentSize = size
        severityVC.isModalInPopover = false;
        severityVC.modalPresentationStyle = .popover
        severityVC.popoverPresentationController?.sourceView = view
        severityVC.popoverPresentationController?.sourceRect = view.bounds
        self.parentViewController()?.present(severityVC, animated: true, completion: nil)
    }
}
