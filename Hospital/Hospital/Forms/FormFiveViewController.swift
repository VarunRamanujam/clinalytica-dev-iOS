//
//  FormFiveViewController.swift
//  Hospital
//
//  Created by Shridhar on 2/1/17.
//
//

import UIKit
import BEMCheckBox

class FormFiveViewController: FormViewController {

    let formFiveObject = AdverseEventsForm5()
    
    @IBOutlet var studyWeekNumbetTF: RUITextField!
    @IBOutlet var fromDateView: DateView!
    @IBOutlet var toDateView: DateView!
    
    @IBOutlet var haveYouBeenFeelingTextView: RUITextView!
    
    @IBOutlet var havePastProblemsStackView: RUIStackView!
    var havePastProblemsOptionsGroup = BEMCheckBoxGroup()
    @IBOutlet var pastProblemsTableView: PastProblemsForm16TableView!
    @IBOutlet var pastProblemsTableHeight: NSLayoutConstraint!
    @IBOutlet var pastProblemsMaskView: RUIView!
    var havePastProblems : Bool? = nil {
        didSet {
            self.view.endEditing(true)
            if havePastProblems == nil {
                pastProblemsMaskView.isHidden = false
            } else {
                pastProblemsMaskView.isHidden = true
            }
        }
    }
    
    
    @IBOutlet var adviceForm17StackView: RUIStackView!
    var adviceForm17OptionsGroup = BEMCheckBoxGroup()
    var haveAdviceForm17 : Bool? = nil
    
    @IBOutlet var randomizationStackView: RUIStackView!
    var randomizationOptionsGroup = BEMCheckBoxGroup()
    var haveRandomization : Bool? = nil
    
    @IBOutlet var commentsTextView: RUITextView!
    
    //BottomView
    @IBOutlet var formCompletedByTF: RUITextField!
    @IBOutlet var investigatorSignatureTF: RUITextField!
    @IBOutlet var signDate: DateView!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initializeFormFormFiveViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        intializeNavigationBar()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        updateHeightConstraint()
        self.perform(#selector(FormTwoViewController.updateHeightConstraint), with: nil, afterDelay: 0.3)
    }
    
    override func clearButtonClicked() {
        
        studyWeekNumbetTF.text = nil
        fromDateView.date = nil
        toDateView.date = nil
        
        haveYouBeenFeelingTextView.text = nil
        
        havePastProblemsOptionsGroup.selectedCheckBox?.on = false
        havePastProblems = nil
        
        adviceForm17OptionsGroup.selectedCheckBox?.on = false
        haveAdviceForm17 = nil
        
        randomizationOptionsGroup.selectedCheckBox?.on = false
        haveRandomization = nil
        
        commentsTextView.text = nil
        
        formCompletedByTF.text = nil
        investigatorSignatureTF.text = nil
        signDate.date = nil

        updateHeightConstraint()
    }
    
    override func submitForm() -> Bool {
        
        fectchModel()
        
        if formFiveObject.isValid() == false {
            showAlrt(fromController: self, title: "Error", message: "Some fields are missing.", cancelText: "OK", cancelAction: nil, otherText: nil, action: nil)
            
            return true
        }
        
        sendRequestToSubmitFormFive()
        
        return true
    }
    
    func updateHeightConstraint() {
        if havePastProblems == nil || havePastProblems! == true {
            pastProblemsTableHeight.constant = pastProblemsTableView.contentSize.height - 6.0
        } else {
            pastProblemsTableHeight.constant = 0.0
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//MARK:- UITextFieldDelegate
extension FormFiveViewController : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let newStr = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
        if textField == studyWeekNumbetTF {
            if newStr.length() > Study_Week_Number_Length {
                return false
            }
            return newStr.canStringBeNumber()
        } else if textField == formCompletedByTF || textField == investigatorSignatureTF {
            return newStr.length() < Text_Length
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
extension FormFiveViewController : HorizontalOptionViewDelegate{
    
    func didTap(sender: HorizontalOptionView, selected: Bool) {
        let pastProblemChildViews = havePastProblemsStackView.arrangedSubviews as! [HorizontalOptionView]
        let adviceForm17StackChildViews = adviceForm17StackView.arrangedSubviews as! [HorizontalOptionView]
        let randomizationStackChildViews = randomizationStackView.arrangedSubviews as! [HorizontalOptionView]
        
        if sender == pastProblemChildViews[0] {
            //Yes
            havePastProblems = true
        } else if sender == pastProblemChildViews[1] {
            //NO
            havePastProblems = false
        } else if sender == adviceForm17StackChildViews[0] {
            //Yes
            haveAdviceForm17 = true
        } else if sender == adviceForm17StackChildViews[1] {
            //NO
            haveAdviceForm17 = false
        } else if sender == randomizationStackChildViews[0] {
            //Yes
            haveRandomization = true
        } else if sender == randomizationStackChildViews[1] {
            //NO
            haveRandomization = false
        }
        
        updateHeightConstraint()
    }
}

extension FormFiveViewController {
    
    func intializeNavigationBar() {
        self.parent?.title = "ADVERSE EVENTS"
    }
    
    func initializeFormFormFiveViewController() {
        
        initializeHavePastProblemsStackView()
        initializeAdviceForm17O()
        initializeRandomizationStackView()
    }
    
    func initializeHavePastProblemsStackView() {
        havePastProblemsOptionsGroup.mustHaveSelection = true
        for view in havePastProblemsStackView.arrangedSubviews as! [HorizontalOptionView] {
            view.delegate = self
            havePastProblemsOptionsGroup.addCheckBox(toGroup: view.checkBox!)
        }
    }

    func initializeAdviceForm17O() {
        adviceForm17OptionsGroup.mustHaveSelection = true
        for view in adviceForm17StackView.arrangedSubviews as! [HorizontalOptionView] {
            view.delegate = self
            adviceForm17OptionsGroup.addCheckBox(toGroup: view.checkBox!)
        }
    }
    
    func initializeRandomizationStackView() {
        randomizationOptionsGroup.mustHaveSelection = true
        for view in randomizationStackView.arrangedSubviews as! [HorizontalOptionView] {
            view.delegate = self
            randomizationOptionsGroup.addCheckBox(toGroup: view.checkBox!)
        }
    }
    
    func fectchModel() {
        
        formFiveObject.patient_initials = FormHeaderInfo.shared.patient_initials
        formFiveObject.study = FormHeaderInfo.shared.study
        formFiveObject.form_no = FormHeaderInfo.shared.form_no
        formFiveObject.center_no = FormHeaderInfo.shared.center
        formFiveObject.patient_number = FormHeaderInfo.shared.patient_number
        
        formFiveObject.vst_date = FormHeaderInfo.shared.vst_date.getString()
        formFiveObject.std_week_no = Int(studyWeekNumbetTF.text!)
        formFiveObject.from_date = fromDateView.date?.getString()
        formFiveObject.to_date = toDateView.date?.getString()
        
        formFiveObject.q1 = haveYouBeenFeelingTextView.text
        
        if havePastProblems != nil && havePastProblemsOptionsGroup.selectedCheckBox != nil {
            formFiveObject.q2.choice = havePastProblemsOptionsGroup.checkBoxes.index(of: havePastProblemsOptionsGroup.selectedCheckBox!) + 1
            
            if havePastProblems! {
                formFiveObject.q2.adverse_events = pastProblemsTableView.pastProbles
            }
        } else {
            formFiveObject.q2.choice = nil
        }
        
        if haveAdviceForm17 != nil && adviceForm17OptionsGroup.selectedCheckBox != nil {
            formFiveObject.q3 = adviceForm17OptionsGroup.checkBoxes.index(of: adviceForm17OptionsGroup.selectedCheckBox!) + 1
        } else {
            formFiveObject.q3 = nil
        }
        
        if haveRandomization != nil && randomizationOptionsGroup.selectedCheckBox != nil {
            formFiveObject.q4 = randomizationOptionsGroup.checkBoxes.index(of: randomizationOptionsGroup.selectedCheckBox!) + 1
        } else {
            formFiveObject.q4 = nil
        }
        
        formFiveObject.comments = commentsTextView.text
        formFiveObject.completed_by = formCompletedByTF.text
        formFiveObject.inv_date = signDate.date?.getString()
    }
    
    func sendRequestToSubmitFormFive() {
        
        if appDelegate.hasConnectivity() == false {
            appDelegate.showMessageHudWithMessage(message: NoInternetAccess, delay: 2.0)
            return
        }
        
        appDelegate.showProgressHudForViewMy(withDetailsLabel: "Please wait…", labelText: "Requesting")
        appManager.sendRequestToSubmitFormFive(formFourObject: formFiveObject) { (response) in
            
            appDelegate.hideProgressHudInView()
            
            if response != nil && response!.isSuccess() {
                self.delegate?.formSubmitted(sender: self)
            } else {
                showAlrt(fromController: self, title: "Error", message: response?.statusMessage ?? ServerError, cancelText: "OK", cancelAction: nil, otherText: nil, action: nil)
            }
        }
    }
}
