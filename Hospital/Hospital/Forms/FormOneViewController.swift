//
//  FormOneViewController.swift
//  Hospital
//
//  Created by Shridhar on 1/31/17.
//
//

import UIKit
import BEMCheckBox

class FormOneViewController: FormViewController {

    var formOneObject = BackgroundInformationForm1()
    
    //Left-Seide Views
    @IBOutlet var addressTF: RUITextField!
    @IBOutlet var workTF: RUITextField!
    @IBOutlet var homePhoneTF: RUITextField!
    @IBOutlet var zipCodeTF: RUITextField!
    @IBOutlet var dateOfBirth: DateView!
    @IBOutlet var genderStackView: RUIStackView!
    var genderOptionsGroup = BEMCheckBoxGroup()
    @IBOutlet var workPastThreeYearsOptionsView: VerticalOptionsView!
    @IBOutlet var incomeTF: RUITextField!
    @IBOutlet var marritalStatusOptions: VerticalOptionsView!
    @IBOutlet var livingArrangementsOptions: VerticalOptionsView!
    
    //Right-Seide Views
    @IBOutlet var raceOptionsView: VerticalOptionsView!
    @IBOutlet var educationOptionsView: VerticalOptionsView!
    @IBOutlet var pastEmployement: VerticalOptionsView!
    @IBOutlet var commutingDistanceWithClinic: RUIStackView!
    var commutingDistanceWithClinicOptionsGroup = BEMCheckBoxGroup()
    @IBOutlet var houseHoldOptionsView: VerticalOptionsView!
    @IBOutlet var goingToJailOptionsView: RUIStackView!
    var goingToJailOptionsGroup = BEMCheckBoxGroup()
    
    //BottomView
    @IBOutlet var commentsTextView: RUITextView!
    @IBOutlet var formCompletedByTF: RUITextField!
    @IBOutlet var investigatorSignatureTF: RUITextField!
    @IBOutlet var signDate: DateView!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initializeFormOneVC()
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
        
        addressTF.text = nil
        workTF.text = nil
        homePhoneTF.text = nil
        zipCodeTF.text = nil
        dateOfBirth.date = nil
        
        genderOptionsGroup.selectedCheckBox?.on = false
        
        workPastThreeYearsOptionsView.deselectAllSelctions()
        
        incomeTF.text = nil
        marritalStatusOptions.deselectAllSelctions()
        livingArrangementsOptions.deselectAllSelctions()
        
        raceOptionsView.deselectAllSelctions()
        educationOptionsView.deselectAllSelctions()
        pastEmployement.deselectAllSelctions()
        
        commutingDistanceWithClinicOptionsGroup.selectedCheckBox?.on = false
        
        houseHoldOptionsView.deselectAllSelctions()
        
        goingToJailOptionsGroup.selectedCheckBox?.on = false
        
        commentsTextView.text = nil
        formCompletedByTF.text = nil
        investigatorSignatureTF.text = nil
        signDate.date = nil
    }
    
    override func submitForm() -> Bool {
        
        fectchModel()
        
        let (valid , errorMessage) = formOneObject.isValid()
        if valid == false {
            showAlrt(fromController: self, title: "Error", message: errorMessage, cancelText: "OK", cancelAction: nil, otherText: nil, action: nil)
            
            return true
        }
        
        sendRequestToSubmitFormOne()
        
        return true
    }
}

//MARK:- UITextFieldDelegate Methods
extension FormOneViewController : UITextFieldDelegate, UITextViewDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let newStr = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
        
        if textField == addressTF || textField == formCompletedByTF || textField == investigatorSignatureTF {
            return newStr.length() < Text_Length
        } else if textField == workTF || textField == homePhoneTF {
            return newStr.canStringBePhoneNumber()
        } else if textField == zipCodeTF {
            return newStr.canStringBeZipcode()
        } else if textField == incomeTF {
            if newStr.length() > Total_Income_Length {
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


//MARK:- Private Methods
extension FormOneViewController {
    
    func intializeNavigationBar() {
        self.parent?.title = "BACKGROUND INFORMATION"
    }
    
    func initializeFormOneVC() {
        //Left-Side Views
        initializeGenderOptions()
        initializeWorkPastThreeYearsOptionsView()
        initializeCommutingDistanceWithClinicOptionsView()
        initializeHouseHoldOptionsView()
        initializeGoingJailOptionsView()
        
        //Right-Side Views
        initializeRaceOptions()
        initializeEducationOptionsView()
        initializePastEmploymentOptionsView()
        initializeMarritalOptionsView()
        initializeLivingArrangements()
    }
}

//MARK:- Left-Side View Functions
extension FormOneViewController {
    func initializeGenderOptions() {
        genderOptionsGroup.mustHaveSelection = true
        for view in genderStackView.arrangedSubviews as! [HorizontalOptionView] {
            genderOptionsGroup.addCheckBox(toGroup: view.checkBox!)
        }
    }
    
    func initializeWorkPastThreeYearsOptionsView() {
        workPastThreeYearsOptionsView.titels = WorkDuringThePast3Years
    }
    
    func initializeMarritalOptionsView() {
        marritalStatusOptions.titels = MaritalOptions
    }
    
    func initializeLivingArrangements() {
        livingArrangementsOptions.titels = UsualLivingArrangementsOptions
    }
}

//MARK:- Right-Side View Functions
extension FormOneViewController {
    func initializeRaceOptions() {
        raceOptionsView.titels = RaceOptions
    }
    
    func initializeEducationOptionsView() {
        educationOptionsView.titels = EducationOptions
    }
    
    func initializePastEmploymentOptionsView() {
        pastEmployement.titels = PastEmploymentOptions
    }
    
    func initializeCommutingDistanceWithClinicOptionsView() {
        commutingDistanceWithClinicOptionsGroup.mustHaveSelection = true
        for view in commutingDistanceWithClinic.arrangedSubviews as! [HorizontalOptionView] {
            commutingDistanceWithClinicOptionsGroup.addCheckBox(toGroup: view.checkBox!)
        }
    }
    
    func initializeHouseHoldOptionsView() {
        houseHoldOptionsView.titels = HouseHoldOptions
    }
    
    func initializeGoingJailOptionsView() {
        goingToJailOptionsGroup.mustHaveSelection = true
        for view in goingToJailOptionsView.arrangedSubviews as! [HorizontalOptionView] {
            goingToJailOptionsGroup.addCheckBox(toGroup: view.checkBox!)
        }
    }
    
    func fectchModel() {
        formOneObject.patient_initials = FormHeaderInfo.shared.patient_initials
        formOneObject.study = FormHeaderInfo.shared.study
        formOneObject.form_no = FormHeaderInfo.shared.form_no
        formOneObject.center = FormHeaderInfo.shared.center
        formOneObject.patient_number = FormHeaderInfo.shared.patient_number
        formOneObject.vst_date = FormHeaderInfo.shared.vst_date?.getString()
        
        formOneObject.current_address = addressTF.text
        formOneObject.zip_code = zipCodeTF.text
        formOneObject.work_phone = workTF.text
        formOneObject.home_phone = homePhoneTF.text
        
        formOneObject.dob = dateOfBirth.date?.getString()
        
        formOneObject.q2 = getValueFromVerticalView(raceOptionsView: raceOptionsView)
        formOneObject.q3 = nil
        if let checkbox = genderOptionsGroup.selectedCheckBox {
            formOneObject.q3 = genderOptionsGroup.checkBoxes.index(of: checkbox) + 1
        }
        
        formOneObject.q4 = getValueFromVerticalView(raceOptionsView: educationOptionsView)
        formOneObject.q5 = getValueFromVerticalView(raceOptionsView: workPastThreeYearsOptionsView)
        formOneObject.q6 = getValueFromVerticalView(raceOptionsView: pastEmployement)
        formOneObject.q7 = incomeTF.text?.toInt()
        formOneObject.q8 = getValueFromVerticalView(raceOptionsView: marritalStatusOptions)
        formOneObject.q9 = getValueFromVerticalView(raceOptionsView: livingArrangementsOptions)
        formOneObject.q10 = nil
        if let checkbox = commutingDistanceWithClinicOptionsGroup.selectedCheckBox {
            formOneObject.q10 = commutingDistanceWithClinicOptionsGroup.checkBoxes.index(of: checkbox) + 1
        }
        
        formOneObject.q11 = getValueFromVerticalView(raceOptionsView: houseHoldOptionsView)
        formOneObject.q12 = nil
        if let checkbox = goingToJailOptionsGroup.selectedCheckBox {
            formOneObject.q12 = goingToJailOptionsGroup.checkBoxes.index(of: checkbox) + 1
        }
        
        formOneObject.comments = commentsTextView.text
        formOneObject.completed_by = formCompletedByTF.text
        formOneObject.date_of_inv = signDate.date?.getString()
    }
    
    private func getValueFromVerticalView(raceOptionsView: VerticalOptionsView) -> Int? {
        let value = raceOptionsView.getSelectedIndexValue()
        return value == nil ? nil : value! + 1
    }
    
    func sendRequestToSubmitFormOne() {
        
        if appDelegate.hasConnectivity() == false {
            appDelegate.showMessageHudWithMessage(message: NoInternetAccess, delay: 2.0)
            return
        }
        
        appDelegate.showProgressHudForViewMy(withDetailsLabel: "Please wait…", labelText: "Requesting")
        appManager.sendRequestToSubmitFormOne(formOneObject: formOneObject) { (response) in
            
            appDelegate.hideProgressHudInView()
            
            
            if response != nil && response!.isSuccess() {
                self.formSubmitted()
            } else {
                showAlrt(fromController: self, title: "Error", message: response?.statusMessage ?? ServerError, cancelText: "OK", cancelAction: nil, otherText: nil, action: nil)
            }
        }
    }
}
