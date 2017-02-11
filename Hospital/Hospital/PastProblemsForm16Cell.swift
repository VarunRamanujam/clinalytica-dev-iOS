//
//  PastProblemsForm16Cell.swift
//  Hospital
//
//  Created by Shridhar on 2/8/17.
//
//

import UIKit

class PastProblemsForm16Cell: RUITableViewCell, DateViewDelegate, OptionsPopOverViewControllerDelegate {
    
    @IBOutlet var natureOfIllnessTF: RUITextField!
    @IBOutlet var medicalEventCodeTF: RUITextField!
    @IBOutlet var dateOfOnset: DateView!
    @IBOutlet var dateOfResolution: DateView!
    @IBOutlet var typeOfReportButton: RUIButton!
    @IBOutlet var relatednessButton: RUIButton!
    @IBOutlet var severityButton: RUIButton!
    @IBOutlet var actionTakenButton: RUIButton!
    @IBOutlet var outcomeButton: RUIButton!
    
    var pastProblem : PastProblemForm16! {
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
            pastProblem.dateOfOnSet = newDate
        } else if dateOfResolution == sender {
            pastProblem.dateOfResolution = newDate
        }
    }
    
    func didSelectOption(sender: OptionsPopOverViewController, index: Int, title: String) {
        if sender.popoverPresentationController?.sourceView == typeOfReportButton {
            typeOfReportButton.setTitle("\(index + 1)", for: UIControlState.normal)
        } else if sender.popoverPresentationController?.sourceView == relatednessButton {
            relatednessButton.setTitle("\(index + 1)", for: UIControlState.normal)
        } else if sender.popoverPresentationController?.sourceView == severityButton {
            severityButton.setTitle("\(index + 1)", for: UIControlState.normal)
        } else if sender.popoverPresentationController?.sourceView == actionTakenButton {
            actionTakenButton.setTitle("\(index + 1)", for: UIControlState.normal)
        } else if sender.popoverPresentationController?.sourceView == outcomeButton {
            outcomeButton.setTitle("\(index + 1)", for: UIControlState.normal)
        }
    }
    
    @IBAction func typeOfReportButtonClicked(_ sender: RUIButton) {
        presentOptionsViewCntl(options: TypeOfReportptions, view: sender, size: CGSize(width: 250, height: 435), title: "Type Of Report")
    }
    
    @IBAction func relatednessButtonClicked(_ sender: RUIButton) {
        presentOptionsViewCntl(options: RelatednessOptions, view: sender, size: CGSize(width: 250, height: 350), title: "Relatedness")
    }
    
    @IBAction func severityButtonClicked(_ sender: RUIButton) {
        presentOptionsViewCntl(options: SeverityOptions, view: sender, size: CGSize(width: 250, height: 220), title: "Severity")
    }
    
    @IBAction func ActionTakenButtonClicked(_ sender: RUIButton) {
        presentOptionsViewCntl(options: ActionTakenForm16Options, view: sender, size: CGSize(width: 350, height: 350), title: "Action Taken")
    }
    
    @IBAction func outcomeButtonClicked(_ sender: RUIButton) {
        presentOptionsViewCntl(options: OutcomeForm16Options, view: sender, size: CGSize(width: 350, height: 350), title: "Outcome")
    }
}

//MARK:- Private Methods
extension PastProblemsForm16Cell {
    func initializepastProblemCell() {
        dateOfOnset.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(PastProblemsCell.natureOfProblemTextDidChange(sender:)), name: NSNotification.Name.UITextFieldTextDidChange, object: natureOfIllnessTF)
        NotificationCenter.default.addObserver(self, selector: #selector(PastProblemsCell.medicalEventCodeTextDidChange(sender:)), name: NSNotification.Name.UITextFieldTextDidChange, object: medicalEventCodeTF)
    }
    
    func updatedData() {
        natureOfIllnessTF.text = pastProblem.natureOfIllness
        medicalEventCodeTF.text = pastProblem.eventCode
        dateOfOnset.date = pastProblem.dateOfOnSet
        
        if pastProblem.tyoeOfReport != nil {
            typeOfReportButton.setTitle("\(pastProblem.tyoeOfReport!)", for: UIControlState.normal)
        } else {
            typeOfReportButton.setTitle("", for: UIControlState.normal)
        }
        
        if pastProblem.relatedness != nil {
            severityButton.setTitle("\(pastProblem.relatedness!)", for: UIControlState.normal)
        } else {
            relatednessButton.setTitle("", for: UIControlState.normal)
        }
        
        if pastProblem.severity != nil {
            severityButton.setTitle("\(pastProblem.severity!)", for: UIControlState.normal)
        } else {
            severityButton.setTitle("", for: UIControlState.normal)
        }
        
        if pastProblem.ationTaken != nil {
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
        pastProblem.eventCode = medicalEventCodeTF.text
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

