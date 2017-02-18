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
    
    var formThreeInfo = LaboratoryReportForm3()
    
    @IBOutlet var ratingPeriodStackView: RUIStackView!
    var ratingPeriodOptionsGroup = BEMCheckBoxGroup()
    var ratingPeriodOption : Int? = nil
    
    @IBOutlet var sampleDrawnDate: DateView!
    @IBOutlet var sampleDrawnTime: DateView!
    
    //HEMATOLOGY
    @IBOutlet var totalWBCTF: RUITextField!
    @IBOutlet var totalRBCTF: RUITextField!
    @IBOutlet var plateletCountTF: RUITextField!
    @IBOutlet var hemoglobinTF: RUITextField!
    @IBOutlet var hematocritTF: RUITextField!
    
    @IBOutlet var neutrophilsTF: RUITextField!
    @IBOutlet var lymphocytesTF: RUITextField!
    @IBOutlet var monocytesTF: RUITextField!
    @IBOutlet var eosinophilsTF: RUITextField!
    @IBOutlet var basophilsTF: RUITextField!
    
    
    //BLOOD CHEMISTRY
    @IBOutlet var GlucoseTF: RUITextField!
    @IBOutlet var totalProteinTF: RUITextField!
    @IBOutlet var albuminTF: RUITextField!
    @IBOutlet var bunTF: RUITextField!
    @IBOutlet var creatinineTF: RUITextField!
    
    @IBOutlet var sgotTF: RUITextField!
    @IBOutlet var sgptTF: RUITextField!
    @IBOutlet var ggtTF: RUITextField!
    @IBOutlet var alkPhosphataseTF: RUITextField!
    @IBOutlet var totalBilirubin: RUITextField!
    
    
    //Liver function
    @IBOutlet var liverFunctionTestStackView: RUIStackView!
    var liverFunctionOptionsGroup = BEMCheckBoxGroup()
    var liverFunctionOption : Int? = nil
    
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
    @IBOutlet var abnormalResultsMaskView: RUIView!
    var isAbnormalResultObserved : Bool? = nil {
        didSet {
            self.view.endEditing(true)
            
            if isAbnormalResultObserved == nil ||
                isAbnormalResultObserved! == true {
                //YES
                abnormalResultsTextViewHeight.constant = 128
            } else {
                //No
                abnormalResultsTextViewHeight.constant = 0
            }
            
            if isAbnormalResultObserved == nil {
                abnormalResultsMaskView.isHidden = false
            } else {
                abnormalResultsMaskView.isHidden = true
            }
        }
    }
    
    //PREGNANCY TEST
    @IBOutlet var pregnancyTestStackView: RUIStackView!
    var pregnancyTestOptionsGroup = BEMCheckBoxGroup()
    var pregnancyTestOption : Int? = nil
    
    //BLOOD LEVELS
    @IBOutlet var bloodLevelStackView: RUIStackView!
    var bloodLevelOptionsGroup = BEMCheckBoxGroup()
    var bloodLevelOption : Int? = nil
    
    @IBOutlet var dateSentToUtah: DateView!
    
    //Comments
    @IBOutlet var commentTextView: RUITextView!
    
    //BottomView
    @IBOutlet var formCompletedByTF: RUITextField!
    @IBOutlet var investigatorSignatureTF: RUITextField!
    @IBOutlet var signDate: DateView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initilizeFormThreeController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        intializeNavigationBar()
    }
    
    override func clearButtonClicked() {
        
        ratingPeriodOptionsGroup.selectedCheckBox?.on = false
        ratingPeriodOption = nil
        
        sampleDrawnDate.date = nil
        sampleDrawnTime.date = nil
        
        totalWBCTF.text = nil
        totalRBCTF.text = nil
        plateletCountTF.text = nil
        hemoglobinTF.text = nil
        hematocritTF.text = nil
        
        neutrophilsTF.text = nil
        lymphocytesTF.text = nil
        monocytesTF.text = nil
        eosinophilsTF.text = nil
        basophilsTF.text = nil
        
        GlucoseTF.text = nil
        totalProteinTF.text = nil
        albuminTF.text = nil
        bunTF.text = nil
        creatinineTF.text = nil
        
        sgotTF.text = nil
        sgptTF.text = nil
        ggtTF.text = nil
        alkPhosphataseTF.text = nil
        totalBilirubin.text = nil
        
        liverFunctionOptionsGroup.selectedCheckBox?.on = false
        liverFunctionOption = nil
        
        
        specificGravityTf.text = nil
        reactionTF.text = nil
        albuminButton.setTitle(nil, for: .normal)
        glucoseButton.setTitle(nil, for: .normal)
        acetoneButton.setTitle(nil, for: .normal)
        wbcsButton.setTitle(nil, for: .normal)
        rbcsButton.setTitle(nil, for: .normal)
        epithelialCellButton.setTitle(nil, for: .normal)
        
        abnormalResultOptionsGroup.selectedCheckBox?.on = false
        isAbnormalResultObserved = nil
        
        
        pregnancyTestOptionsGroup.selectedCheckBox?.on = false
        pregnancyTestOption = nil
        
        bloodLevelOptionsGroup.selectedCheckBox?.on = false
        bloodLevelOption = nil
        
        dateSentToUtah.date = nil
        
        commentTextView.text = nil
        
        formCompletedByTF.text = nil
        investigatorSignatureTF.text = nil
        signDate.date = nil
    }
    
    override func submitForm() -> Bool {
        
        fectchModel()
        
        if formThreeInfo.isValid() == false {
            showAlrt(fromController: self, title: "Error", message: ErrorMissingFields, cancelText: "OK", cancelAction: nil, otherText: nil, action: nil)
            
            return true
        }
        
        sendRequestToSubmitFormThree()
        
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//MARK:- UITextFieldDelegate Methods
extension FormThreeController : UITextFieldDelegate, UITextViewDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let newStr = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
        
        let hematologyTF = (textField == totalWBCTF || textField == neutrophilsTF ||
            textField == totalRBCTF || textField == lymphocytesTF ||
            textField == plateletCountTF || textField == monocytesTF ||
            textField == hemoglobinTF || textField == eosinophilsTF ||
            textField == hematocritTF || textField == basophilsTF)
        
        let bloodChemistryTF = (textField == GlucoseTF || textField == sgotTF ||
            textField == totalProteinTF || textField == sgptTF ||
            textField == albuminTF || textField == ggtTF ||
            textField == bunTF || textField == alkPhosphataseTF ||
            textField == creatinineTF || textField == totalBilirubin)
        
        let urinalysisTF = (textField == specificGravityTf ||
            textField == reactionTF)
        if hematologyTF || bloodChemistryTF || urinalysisTF{
            if newStr.length() > textField.tag {
                return false
            }
            return newStr.canStringBeDecimalNumber()
        }
        
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newStr = (textView.text as NSString?)?.replacingCharacters(in: range, with: text) ?? text
        
        if newStr.length() > Comment_Length {
            return false
        }
        
        return true
    }
}


//MARK:- HorizontalOptionViewDelegate
extension FormThreeController : HorizontalOptionViewDelegate {
    
    func didTap(sender: HorizontalOptionView, selected: Bool) {
        
        let abnormalOptionsChildViews = abnormalResultsStackView.arrangedSubviews as! [HorizontalOptionView]
        
        if abnormalOptionsChildViews[0] == sender {
            //YES
            isAbnormalResultObserved = true
        } else if abnormalOptionsChildViews[1] == sender {
            //No
            isAbnormalResultObserved = false
            
        } else if ratingPeriodStackView.arrangedSubviews.contains(sender) {
            
            ratingPeriodOption = ratingPeriodStackView.arrangedSubviews.index(of: sender)
            
        } else if liverFunctionTestStackView.arrangedSubviews.contains(sender) {
            
            liverFunctionOption = liverFunctionTestStackView.arrangedSubviews.index(of: sender)
            
        } else if pregnancyTestStackView.arrangedSubviews.contains(sender) {
            
            pregnancyTestOption = pregnancyTestStackView.arrangedSubviews.index(of: sender)
            
        } else if bloodLevelStackView.arrangedSubviews.contains(sender) {
            
            bloodLevelOption = bloodLevelStackView.arrangedSubviews.index(of: sender)
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
        presentOptionsViewCntl(options: Glucose, view: sender, size: CGSize(width: 250, height: 275), title: "", showSerialNumbers: false)
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
    
    func intializeNavigationBar() {
        self.parent?.title = "LABORATORY REPORT"
    }
    
    func initilizeFormThreeController() {
        
        setTags()
        initilizeRatingPeriodOptions()
        initilizeLiverFunctionOptions()
        initilizeAbnormalResultsOptions()
        initilizePregnancyTestOptions()
        initilizeBloodLevelOptions()
    }
    
    func setTags() {
        
        totalWBCTF.tag = 8
        totalRBCTF.tag = 8
        plateletCountTF.tag = 4
        hemoglobinTF.tag = 8
        hematocritTF.tag = 8
        neutrophilsTF.tag = 3
        lymphocytesTF.tag = 3
        monocytesTF.tag = 3
        eosinophilsTF.tag = 3
        basophilsTF.tag = 3
        
        GlucoseTF.tag = 4
        totalProteinTF.tag = 8
        albuminTF.tag = 8
        bunTF.tag = 3
        creatinineTF.tag = 8
        sgotTF.tag = 4
        sgptTF.tag = 4
        ggtTF.tag = 4
        alkPhosphataseTF.tag = 4
        totalBilirubin.tag = 8
        
        specificGravityTf.tag = 8
        reactionTF.tag = 8
    }
    
    func initilizeRatingPeriodOptions() {
        ratingPeriodOptionsGroup.mustHaveSelection = true
        for childView in ratingPeriodStackView.arrangedSubviews as! [HorizontalOptionView] {
            childView.delegate = self
            ratingPeriodOptionsGroup.addCheckBox(toGroup: childView.checkBox!)
        }
    }
    
    func initilizeLiverFunctionOptions() {
        liverFunctionOptionsGroup.mustHaveSelection = true
        for childView in liverFunctionTestStackView.arrangedSubviews as! [HorizontalOptionView] {
            childView.delegate = self
            liverFunctionOptionsGroup.addCheckBox(toGroup: childView.checkBox!)
        }
    }
    
    func initilizeAbnormalResultsOptions() {
        abnormalResultOptionsGroup.mustHaveSelection = true
        for childView in abnormalResultsStackView.arrangedSubviews as! [HorizontalOptionView] {
            childView.delegate = self
            abnormalResultOptionsGroup.addCheckBox(toGroup: childView.checkBox!)
        }
    }
    
    func initilizePregnancyTestOptions() {
        pregnancyTestOptionsGroup.mustHaveSelection = true
        for childView in pregnancyTestStackView.arrangedSubviews as! [HorizontalOptionView] {
            childView.delegate = self
            pregnancyTestOptionsGroup.addCheckBox(toGroup: childView.checkBox!)
        }
    }
    
    func initilizeBloodLevelOptions() {
        bloodLevelOptionsGroup.mustHaveSelection = true
        for childView in bloodLevelStackView.arrangedSubviews as! [HorizontalOptionView] {
            childView.delegate = self
            bloodLevelOptionsGroup.addCheckBox(toGroup: childView.checkBox!)
        }
    }
    
    func fectchModel() {
        
        formThreeInfo.patient_initials = FormHeaderInfo.shared.patient_initials
        formThreeInfo.study = FormHeaderInfo.shared.study
        formThreeInfo.form_no = FormHeaderInfo.shared.form_no
        formThreeInfo.center = FormHeaderInfo.shared.center
        formThreeInfo.patient_number = FormHeaderInfo.shared.patient_number
        formThreeInfo.vst_date = FormHeaderInfo.shared.vst_date?.getString()
        
        formThreeInfo.rat_per = ratingPeriodOption != nil ? ratingPeriodOption! + 1 : nil
        
        formThreeInfo.date_of_sample = sampleDrawnDate.date?.getString()
        formThreeInfo.time_of_sample = sampleDrawnDate.date?.getTimeString()
        
        formThreeInfo.hematology.removeAll()
        let hematology = HematologyInfo()
        hematology.total_wbc = totalWBCTF.text?.toInt()
        hematology.total_rbc = totalRBCTF.text?.toInt()
        hematology.platelet_count = plateletCountTF.text?.toInt()
        hematology.hemoglobin = hemoglobinTF.text?.toInt()
        hematology.hematocrit = hematocritTF.text?.toInt()
        hematology.neutrophils = neutrophilsTF.text?.toInt()
        hematology.lymphocytes = lymphocytesTF.text?.toInt()
        hematology.monocytes = monocytesTF.text?.toInt()
        hematology.eosinophils = eosinophilsTF.text?.toInt()
        hematology.basophils = basophilsTF.text?.toInt()
        formThreeInfo.hematology.append(hematology)
        
        formThreeInfo.blood_chemistry.removeAll()
        let blood_chemistry = BloodChemistryInfo()
        blood_chemistry.glucose = GlucoseTF.text?.toInt()
        blood_chemistry.total_protein = totalProteinTF.text?.toInt()
        blood_chemistry.albumin = albuminTF.text?.toInt()
        blood_chemistry.bun = bunTF.text?.toInt()
        blood_chemistry.creatinine = creatinineTF.text?.toInt()
        blood_chemistry.sgot = sgotTF.text?.toInt()
        blood_chemistry.sgpt = sgptTF.text?.toInt()
        blood_chemistry.cgt = ggtTF.text?.toInt()
        blood_chemistry.alk_phosphatase = alkPhosphataseTF.text?.toInt()
        blood_chemistry.total_bilirubin = totalBilirubin.text?.toInt()
        blood_chemistry.IRB_notified = 1
        formThreeInfo.blood_chemistry.append(blood_chemistry)
        
        formThreeInfo.urinalysis.removeAll()
        let urinalysis = UrinalysisInfo()
        urinalysis.Specific_gravity = specificGravityTf.text?.toInt()
        urinalysis.reaction = reactionTF.text?.toInt()
        urinalysis.albumin = albuminButton.title(for: .normal)?.toInt()
        urinalysis.glucose = glucoseButton.title(for: .normal)?.toInt()
        urinalysis.acetone = acetoneButton.title(for: .normal)?.toInt()
        urinalysis.wbcs_hpf = wbcsButton.title(for: .normal)?.toInt()
        urinalysis.rbcs_hpf = rbcsButton.title(for: .normal)?.toInt()
        urinalysis.epithelial_cells = epithelialCellButton.title(for: .normal)?.toInt()
        formThreeInfo.urinalysis.append(urinalysis)
        
        formThreeInfo.q30AbnormalResults.removeAll()
        let q30AbnormalResult = AbnormalResults()
        q30AbnormalResult.choice = getNumberFromBool(value: isAbnormalResultObserved)
        q30AbnormalResult.specification = abnormalResultsTextView.text
        formThreeInfo.q30AbnormalResults.append(q30AbnormalResult)
        
        formThreeInfo.q31PregnancyTest = pregnancyTestOption != nil ? pregnancyTestOption! + 1 : nil
        formThreeInfo.q32BloodDrawn = bloodLevelOption != nil ? bloodLevelOption! + 1 : nil
        formThreeInfo.q33DateSent = dateSentToUtah.date?.getString()
        
        formThreeInfo.comments = commentTextView.text
        formThreeInfo.completed_by = formCompletedByTF.text
        formThreeInfo.date_of_inv = signDate.date?.getString()
    }
    
    func getNumberFromBool(value : Bool?) -> Int? {
        if value == nil {
            return nil
        }
        
        return value! ? 1 : 2
    }
    
    func sendRequestToSubmitFormThree() {
        
        if appDelegate.hasConnectivity() == false {
            appDelegate.showMessageHudWithMessage(message: NoInternetAccess, delay: 2.0)
            return
        }
        
        appDelegate.showProgressHudForViewMy(withDetailsLabel: "Please wait…", labelText: "Requesting")
        appManager.sendRequestToSubmitFormThree(formThreeObject: formThreeInfo) { (response) in
            
            appDelegate.hideProgressHudInView()
            
            
            if response != nil && response!.isSuccess() {
                self.formSubmitted()
            } else {
                showAlrt(fromController: self, title: "Error", message: response?.statusMessage ?? ServerError, cancelText: "OK", cancelAction: nil, otherText: nil, action: nil)
            }
        }
    }
    
}
