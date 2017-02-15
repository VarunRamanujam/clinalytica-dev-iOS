//
//  PastProblemsCell.swift
//  Hospital
//
//  Created by Shridhar on 2/5/17.
//
//

import UIKit

class PastProblemsCell: RUITableViewCell, DateViewDelegate, OptionsPopOverViewControllerDelegate {

    @IBOutlet var natureOfIllnessTF: RUITextField!
    @IBOutlet var medicalEventCodeTF: RUITextField!
    @IBOutlet var dateOfOnset: DateView!
    @IBOutlet var dateOfResolution: DateView!
    @IBOutlet var severityButton: RUIButton!
    @IBOutlet var actionTakenButton: RUIButton!
    @IBOutlet var outcomeButton: RUIButton!
    
    var pastProblem : PastProblem! {
        didSet {
            updatedData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        initializepastProblemCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func dateChanged(sender: DateView, newDate: Date) {
        if dateOfOnset == sender {
            pastProblem.dateOfOnSet = newDate.getString()
        } else if dateOfResolution == sender {
            pastProblem.dateOfResolution = newDate.getString()
        }
    }
    
    func didSelectOption(sender: OptionsPopOverViewController, index: Int, title: String) {
        if sender.popoverPresentationController?.sourceView == severityButton {
            severityButton.setTitle("\(index + 1)", for: UIControlState.normal)
            pastProblem.severity = index + 1
        } else if sender.popoverPresentationController?.sourceView == actionTakenButton {
            actionTakenButton.setTitle("\(index + 1)", for: UIControlState.normal)
            pastProblem.ationTaken = index + 1
        } else if sender.popoverPresentationController?.sourceView == outcomeButton {
            outcomeButton.setTitle("\(index + 1)", for: UIControlState.normal)
            pastProblem.outCome = index + 1
        }
    }
    
    @IBAction func severityButtonClicked(_ sender: RUIButton) {
        presentOptionsViewCntl(options: SeverityOptions, view: sender, size: CGSize(width: 250, height: 220), title: "Severity")
    }
    
    @IBAction func ActionTakenButtonClicked(_ sender: RUIButton) {
        presentOptionsViewCntl(options: ActionTakenOptions, view: sender, size: CGSize(width: 350, height: 350), title: "Action Taken")
    }
    
    @IBAction func outcomeButtonClicked(_ sender: RUIButton) {
        presentOptionsViewCntl(options: OutcomeOptions, view: sender, size: CGSize(width: 350, height: 350), title: "Outcome")
    }
}

//MARK:- UITextFieldDelegate
extension PastProblemsCell : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let newStr = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
        if textField == medicalEventCodeTF {
            if newStr.length() > Medical_Event_Code_Length {
                return false
            }
            return newStr.canStringBeNumber()
        } else if textField == natureOfIllnessTF {
            if newStr.length() > Text_Length {
                return false
            }
        }
        
        return true
    }
}

//MARK:- Private Methods
extension PastProblemsCell {
    func initializepastProblemCell() {
        medicalEventCodeTF.delegate = self
        dateOfOnset.delegate = self
        dateOfResolution.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(PastProblemsCell.natureOfProblemTextDidChange(sender:)), name: NSNotification.Name.UITextFieldTextDidChange, object: natureOfIllnessTF)
        NotificationCenter.default.addObserver(self, selector: #selector(PastProblemsCell.medicalEventCodeTextDidChange(sender:)), name: NSNotification.Name.UITextFieldTextDidChange, object: medicalEventCodeTF)
    }
    
    func updatedData() {
        natureOfIllnessTF.text = pastProblem.natureOfIllness
        if pastProblem.eventCode != nil && pastProblem.eventCode != 0 {
            medicalEventCodeTF.text = "\(pastProblem.eventCode!)"
        } else {
            medicalEventCodeTF.text = ""
        }
        
        dateOfOnset.date = Date.getDate(str: pastProblem.dateOfOnSet)
        
        if pastProblem.severity != nil &&
            pastProblem.severity != 0{
            severityButton.setTitle("\(pastProblem.severity!)", for: UIControlState.normal)
        } else {
            severityButton.setTitle("", for: UIControlState.normal)
        }
        
        if pastProblem.ationTaken != nil &&
            pastProblem.ationTaken != 0 {
            actionTakenButton.setTitle("\(pastProblem.ationTaken!)", for: UIControlState.normal)
        } else {
            actionTakenButton.setTitle("", for: UIControlState.normal)
        }
        
        if pastProblem.outCome != nil {
            outcomeButton.setTitle("\(pastProblem.outCome!)", for: UIControlState.normal)
        } else {
            outcomeButton.setTitle("", for: UIControlState.normal)
        }
        
    }
    
    func natureOfProblemTextDidChange(sender : Notification) {
        pastProblem.natureOfIllness = natureOfIllnessTF.text
    }
    
    func medicalEventCodeTextDidChange(sender : Notification) {
        if isEmptyString(string: medicalEventCodeTF.text) == false {
            pastProblem.eventCode = Int(medicalEventCodeTF.text!)
        }
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
