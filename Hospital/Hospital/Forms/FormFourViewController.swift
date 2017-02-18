//
//  FormFourViewController.swift
//  Hospital
//
//  Created by Shridhar on 2/1/17.
//
//

import UIKit
import BEMCheckBox

class FormFourViewController: FormViewController, HorizontalOptionViewDelegate {

    var formFourObject = StudyAdmissionForm4()
    
    @IBOutlet var oneToFiveQuestionsStackView: RUIStackView!
    @IBOutlet var sixToFifteenQuestionsStackView: RUIStackView!
    
    @IBOutlet var OtherTF: RUITextField!
    @IBOutlet var sixteenthQuestionYesOrNoStackView: RUIStackView!
    var sixteenthQuestionGroup = BEMCheckBoxGroup()
    var sixteenthQuestionOption : Bool?
    
    @IBOutlet var seventeenthQuestion: QuestionYesOrNoView!
    
    @IBOutlet var dateRandomized: DateView!
    @IBOutlet var dateOfFirstDose: DateView!
    
    //BottomView
    @IBOutlet var formCompletedByTF: RUITextField!
    @IBOutlet var investigatorSignatureTF: RUITextField!
    @IBOutlet var signDate: DateView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initializeFormFourViewController()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        intializeNavigationBar()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func clearButtonClicked() {
        
        for questionView in oneToFiveQuestionsStackView.arrangedSubviews as! [QuestionYesOrNoView] {
            questionView.unSelectOptions()
        }
        
        for questionView in sixToFifteenQuestionsStackView.arrangedSubviews as! [QuestionYesOrNoView] {
            questionView.unSelectOptions()
        }
        
        OtherTF.text = nil
        sixteenthQuestionGroup.selectedCheckBox?.on = false
        sixteenthQuestionOption = nil
        
        seventeenthQuestion.unSelectOptions()
        
        dateRandomized.date = nil
        dateOfFirstDose.date = nil
        
        formCompletedByTF.text = nil
        investigatorSignatureTF.text = nil
        signDate.date = nil
    }
    
    override func submitForm() -> Bool {
        
        fectchModel()
        
        if formFourObject.isValid() == false {
            showAlrt(fromController: self, title: "Error", message: ErrorMissingFields, cancelText: "OK", cancelAction: nil, otherText: nil, action: nil)
            
            return true
        }
        
        sendRequestToSubmitFormFour()
        
        return true
    }
    
    func didTap(sender: HorizontalOptionView, selected: Bool) {
        let childViews = sixteenthQuestionYesOrNoStackView.arrangedSubviews as! [HorizontalOptionView]
        
        if OtherTF.text != nil && OtherTF.text!.length() > 0 {
            if childViews[0] == sender {
                sixteenthQuestionOption = true
            } else if childViews[1] == sender {
                sixteenthQuestionOption = false
            }
        } else {
            sixteenthQuestionOption = nil
            sender.checkBox?.on = false
        }
    }
}

//MARK:- UITextFieldDelegate Methods
extension FormFourViewController : UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let newStr = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
        
        if textField == formCompletedByTF || textField == investigatorSignatureTF || textField == OtherTF {
            return newStr.length() < Text_Length
        }
        
        return true
    }
}

//MARK:- Private Methods
extension FormFourViewController {
    func intializeNavigationBar() {
        self.parent?.title = "STUDY ADMISSION"
    }
    
    func initializeFormFourViewController() {
        updateQuestionStackViews()
    }
    
    private func updateQuestionStackViews() {
        
        for view in oneToFiveQuestionsStackView.arrangedSubviews {
            oneToFiveQuestionsStackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
        
        for i in 1...5 {
            let questionView = QuestionYesOrNoView(frame: CGRect(x: 0, y: 0, width: oneToFiveQuestionsStackView.frame.width, height: 30))
            questionView.title = StudyAdmissionQuestions[i-1]
            questionView.serialNumber = i
            oneToFiveQuestionsStackView.addArrangedSubview(questionView)
        }
        
        for view in sixToFifteenQuestionsStackView.arrangedSubviews {
            sixToFifteenQuestionsStackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
        
        for i in 6...15 {
            let questionView = QuestionYesOrNoView(frame: CGRect(x: 0, y: 0, width: sixToFifteenQuestionsStackView.frame.width, height: 30))
            questionView.title = StudyAdmissionQuestions[i-1]
            questionView.serialNumber = i
            sixToFifteenQuestionsStackView.addArrangedSubview(questionView)
        }
        
        sixteenthQuestionGroup.mustHaveSelection = true
        for childView in sixteenthQuestionYesOrNoStackView.arrangedSubviews as! [HorizontalOptionView] {
            childView.delegate = self
            sixteenthQuestionGroup.addCheckBox(toGroup: childView.checkBox!)
        }
        
        seventeenthQuestion.title = StudyAdmissionQuestions[17-1]
        seventeenthQuestion.serialNumber = 17
    }
    
    func fectchModel() {
        
        var q16     : Int!
        var q16_spec: String!
        var q17     = Dates()
        var completed_by: String!
        var date_of_inv : String!
        
        formFourObject.patient_initials = FormHeaderInfo.shared.patient_initials
        formFourObject.study = FormHeaderInfo.shared.study
        formFourObject.form_no = FormHeaderInfo.shared.form_no
        formFourObject.center_no = FormHeaderInfo.shared.center
        formFourObject.patient_number = FormHeaderInfo.shared.patient_number
        formFourObject.vst_date = FormHeaderInfo.shared.vst_date.getString()
        
        let oneToFiveQuestions = oneToFiveQuestionsStackView.arrangedSubviews as! [QuestionYesOrNoView]
        formFourObject.q1 = getNumberFromBool(value: oneToFiveQuestions[0].getStausValue())
        formFourObject.q2 = getNumberFromBool(value: oneToFiveQuestions[1].getStausValue())
        formFourObject.q3 = getNumberFromBool(value: oneToFiveQuestions[2].getStausValue())
        formFourObject.q4 = getNumberFromBool(value: oneToFiveQuestions[3].getStausValue())
        formFourObject.q5 = getNumberFromBool(value: oneToFiveQuestions[4].getStausValue())
        
        let sixToFifteenQuestions = sixToFifteenQuestionsStackView.arrangedSubviews as! [QuestionYesOrNoView]
        formFourObject.q6 = getNumberFromBool(value: sixToFifteenQuestions[0].getStausValue())
        formFourObject.q7 = getNumberFromBool(value: sixToFifteenQuestions[1].getStausValue())
        formFourObject.q8 = getNumberFromBool(value: sixToFifteenQuestions[2].getStausValue())
        formFourObject.q9 = getNumberFromBool(value: sixToFifteenQuestions[3].getStausValue())
        formFourObject.q10 = getNumberFromBool(value: sixToFifteenQuestions[4].getStausValue())
        formFourObject.q11 = getNumberFromBool(value: sixToFifteenQuestions[5].getStausValue())
        formFourObject.q12 = getNumberFromBool(value: sixToFifteenQuestions[6].getStausValue())
        formFourObject.q13 = getNumberFromBool(value: sixToFifteenQuestions[7].getStausValue())
        formFourObject.q14 = getNumberFromBool(value: sixToFifteenQuestions[8].getStausValue())
        formFourObject.q15 = getNumberFromBool(value: sixToFifteenQuestions[9].getStausValue())
        
        formFourObject.q16_spec = OtherTF.text
        if isEmptyString(string: formFourObject.q16_spec) == false {
            formFourObject.q16 = getNumberFromBool(value: sixteenthQuestionOption)
        }
        
        formFourObject.q17.main = getNumberFromBool(value: seventeenthQuestion.getStausValue())
        formFourObject.q17.date_randomized = dateRandomized.date?.getString()
        formFourObject.q17.date_frstdose = dateOfFirstDose.date?.getString()
        
        formFourObject.completed_by = formCompletedByTF.text
        formFourObject.date_of_inv = signDate.date?.getString()
    }
    
    func getNumberFromBool(value : Bool?) -> Int? {
        if value == nil {
            return nil
        }
        
        return value! ? 1 : 2
    }

    func sendRequestToSubmitFormFour() {
        
        if appDelegate.hasConnectivity() == false {
            appDelegate.showMessageHudWithMessage(message: NoInternetAccess, delay: 2.0)
            return
        }
        
        appDelegate.showProgressHudForViewMy(withDetailsLabel: "Please wait…", labelText: "Requesting")
        appManager.sendRequestToSubmitFormFour(formFourObject: formFourObject) { (response) in
            
            appDelegate.hideProgressHudInView()
            
            if response != nil && response!.isSuccess() {
                self.formSubmitted()
            } else {
                showAlrt(fromController: self, title: "Error", message: response?.statusMessage ?? ServerError, cancelText: "OK", cancelAction: nil, otherText: nil, action: nil)
            }
        }
    }
}
