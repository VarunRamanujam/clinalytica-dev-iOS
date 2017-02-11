//
//  FormThreeController.swift
//  Hospital
//
//  Created by Shridhar on 2/1/17.
//
//

import UIKit
import BEMCheckBox

class FormThreeController: FormViewController {

    @IBOutlet var ratingPeriodStackView: RUIStackView!
    var ratingPeriodOptionsGroup = BEMCheckBoxGroup()
    
    @IBOutlet var sampleDrawnDate: DateView!
    @IBOutlet var sampleDrawnTime: DateView!
    
    //HEMATOLOGY
    @IBOutlet var totalWBCTF: RUITextField!
    @IBOutlet var totalRBCTF: RUITextField!
    @IBOutlet var plateletCountTF: RUITextField!
    @IBOutlet var hemoglobinTF: RUITextField!
    @IBOutlet var hematocritTF: RUITextField!
    
    //BLOOD CHEMISTRY
    @IBOutlet var GlucoseTF: RUITextField!
    @IBOutlet var totalProteinTF: RUITextField!
    @IBOutlet var albuminTF: RUITextField!
    @IBOutlet var bunTF: RUITextField!
    @IBOutlet var creatinineTF: RUITextField!
    
    //Liver function
    @IBOutlet var liverFunctionTestStackView: RUIStackView!
    var liverFunctionOptionsGroup = BEMCheckBoxGroup()
    
    //URINALYSIS
    @IBOutlet var specificGravityTf: RUITextField!
    @IBOutlet var reactionTF: RUITextField!
    @IBOutlet var albuminButton: RUIButton!
    @IBOutlet var glucoseButton: RUIButton!
    @IBOutlet var acetoneButton: RUIButton!
    @IBOutlet var wbcsButton: RUIButton!
    @IBOutlet var rbcsButton: RUIButton!
    @IBOutlet var epithelialCellButton: RUIButton!
    
    //Abnormal results
    @IBOutlet var abnormalResultsStackView: RUIStackView!
    var abnormalResultOptionsGroup = BEMCheckBoxGroup()
    @IBOutlet var abnormalResultsTextView: RUITextView!
    @IBOutlet var abnormalResultsTextViewHeight: NSLayoutConstraint!
    
    //PREGNANCY TEST
    @IBOutlet var pregnancyTestStackView: RUIStackView!
    var pregnancyTestOptionsGroup = BEMCheckBoxGroup()
    
    //BLOOD LEVELS
    @IBOutlet var bloodLevelStackView: RUIStackView!
    var bloodLevelOptionsGroup = BEMCheckBoxGroup()
    @IBOutlet var dateSentToUtah: DateView!
    
    //Comments
    @IBOutlet var commentTextView: RUITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initilizeFormThreeController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        intializeNavigationBar()
    }
    func intializeNavigationBar() {
        self.parent?.title = "LABORATORY REPORT"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//MARK:- BEMCheckBoxDelegate
extension FormThreeController : BEMCheckBoxDelegate {
    
    func didTap(_ checkBox: BEMCheckBox) {
        
        let abnormalOptionsChildViews = abnormalResultsStackView.arrangedSubviews as! [HorizontalOptionView]
        if abnormalOptionsChildViews[0].checkBox == checkBox {
            //YES
            abnormalResultsTextViewHeight.constant = 128
        } else if abnormalOptionsChildViews[1].checkBox == checkBox {
            //No
            abnormalResultsTextViewHeight.constant = 0
        }
    }
}

//MARK:- OptionsPopOverViewControllerDelegate
extension FormThreeController : OptionsPopOverViewControllerDelegate {
    func didSelectOption(sender: OptionsPopOverViewController, index: Int, title: String) {
        if sender.popoverPresentationController?.sourceView == albuminButton {
            albuminButton.setTitle("\(index + 1)", for: UIControlState.normal)
        } else if sender.popoverPresentationController?.sourceView == glucoseButton {
            glucoseButton.setTitle(title, for: UIControlState.normal)
        } else if sender.popoverPresentationController?.sourceView == acetoneButton {
            acetoneButton.setTitle("\(index + 1)", for: UIControlState.normal)
        } else if sender.popoverPresentationController?.sourceView == wbcsButton {
            wbcsButton.setTitle("\(index + 1)", for: UIControlState.normal)
        } else if sender.popoverPresentationController?.sourceView == rbcsButton {
            rbcsButton.setTitle("\(index + 1)", for: UIControlState.normal)
        } else if sender.popoverPresentationController?.sourceView == epithelialCellButton {
            epithelialCellButton.setTitle("\(index + 1)", for: UIControlState.normal)
        }
    }
}

//MARK:- Button Actions
extension FormThreeController {
    @IBAction func albuminButtonClicked(_ sender: RUIButton) {
        presentOptionsViewCntl(options: Albumin, view: sender, size: CGSize(width: 250, height: 165), title: "")
    }
    
    @IBAction func glucoseButtonClicked(_ sender: RUIButton) {
        presentOptionsViewCntl(options: Glucose, view: sender, size: CGSize(width: 250, height: 220), title: "", showSerialNumbers: false)
    }
    
    @IBAction func acetoneButtonClicked(_ sender: RUIButton) {
        presentOptionsViewCntl(options: Acetone, view: sender, size: CGSize(width: 250, height: 165), title: "")
    }
    
    @IBAction func wbcsButtonClicked(_ sender: RUIButton) {
        presentOptionsViewCntl(options: WBCS, view: sender, size: CGSize(width: 250, height: 220), title: "")
    }
    
    @IBAction func rbcsButtonClicked(_ sender: RUIButton) {
        presentOptionsViewCntl(options: RBCS, view: sender, size: CGSize(width: 250, height: 220), title: "")
    }
    
    @IBAction func epithelialCellsButtonClicked(_ sender: RUIButton) {
        presentOptionsViewCntl(options: EpithelialCells, view: sender, size: CGSize(width: 250, height: 220), title: "")
    }
    
    func presentOptionsViewCntl(options : [String], view : UIView, size : CGSize, title : String?, showSerialNumbers : Bool = true) {
        let severityVC = OptionsPopOverViewController(nibName: "OptionsPopOverViewController", bundle: nil)
        severityVC.options = options
        severityVC.delegate = self
        severityVC.title = title
        severityVC.showSerialNumbers = showSerialNumbers
        severityVC.preferredContentSize = size
        severityVC.isModalInPopover = false;
        severityVC.modalPresentationStyle = .popover
        severityVC.popoverPresentationController?.sourceView = view
        severityVC.popoverPresentationController?.sourceRect = view.bounds
        self.present(severityVC, animated: true, completion: nil)
    }
}

//MARK:- Private Methods
extension FormThreeController {
    
    func initilizeFormThreeController() {
        
        initilizeRatingPeriodOptions()
        initilizeLiverFunctionOptions()
        initilizeAbnormalResultsOptions()
        initilizePregnancyTestOptions()
        initilizeBloodLevelOptions()
    }
    
    func initilizeRatingPeriodOptions() {
        ratingPeriodOptionsGroup.mustHaveSelection = true
        for childView in ratingPeriodStackView.arrangedSubviews as! [HorizontalOptionView] {
            childView.checkBox?.delegate = self
            ratingPeriodOptionsGroup.addCheckBox(toGroup: childView.checkBox!)
        }
    }
    
    func initilizeLiverFunctionOptions() {
        liverFunctionOptionsGroup.mustHaveSelection = true
        for childView in liverFunctionTestStackView.arrangedSubviews as! [HorizontalOptionView] {
            childView.checkBox?.delegate = self
            liverFunctionOptionsGroup.addCheckBox(toGroup: childView.checkBox!)
        }
    }
    
    func initilizeAbnormalResultsOptions() {
        abnormalResultOptionsGroup.mustHaveSelection = true
        for childView in abnormalResultsStackView.arrangedSubviews as! [HorizontalOptionView] {
            childView.checkBox?.delegate = self
            abnormalResultOptionsGroup.addCheckBox(toGroup: childView.checkBox!)
        }
    }
    
    func initilizePregnancyTestOptions() {
        pregnancyTestOptionsGroup.mustHaveSelection = true
        for childView in pregnancyTestStackView.arrangedSubviews as! [HorizontalOptionView] {
            childView.checkBox?.delegate = self
            pregnancyTestOptionsGroup.addCheckBox(toGroup: childView.checkBox!)
        }
    }
    
    func initilizeBloodLevelOptions() {
        bloodLevelOptionsGroup.mustHaveSelection = true
        for childView in bloodLevelStackView.arrangedSubviews as! [HorizontalOptionView] {
            childView.checkBox?.delegate = self
            bloodLevelOptionsGroup.addCheckBox(toGroup: childView.checkBox!)
        }
    }
    
}
