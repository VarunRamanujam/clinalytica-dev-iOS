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

    //Left-Seide Views
    @IBOutlet var addressTF: RUITextField!
    @IBOutlet var workTF: RUITextField!
    @IBOutlet var homePhoneTF: RUITextField!
    @IBOutlet var zipCodeTF: RUITextField!
    @IBOutlet var dateOfBirth: DateView!
    @IBOutlet var genderStackView: UIStackView!
    var genderOptionsGroup = BEMCheckBoxGroup()
    @IBOutlet var workPastThreeYearsOptionsView: VerticalOptionsView!
    @IBOutlet var incomeTF: RUITextField!
    @IBOutlet var marritalStatusOptions: VerticalOptionsView!
    @IBOutlet var livingArrangementsOptions: VerticalOptionsView!
    
    //Right-Seide Views
    @IBOutlet var raceOptionsView: VerticalOptionsView!
    @IBOutlet var educationOptionsView: VerticalOptionsView!
    @IBOutlet var pastEmployement: VerticalOptionsView!
    @IBOutlet var commutingDistanceWithClinic: UIStackView!
    var commutingDistanceWithClinicOptionsGroup = BEMCheckBoxGroup()
    @IBOutlet var houseHoldOptionsView: VerticalOptionsView!
    @IBOutlet var goingToJailOptionsView: RUIStackView!
    var goingToJailOptionsGroup = BEMCheckBoxGroup()
    
    
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
        addressTF.text = ""
        workTF.text = ""
        homePhoneTF.text = ""
        zipCodeTF.text = ""
        dateOfBirth.date = nil
        
        
        genderOptionsGroup.selectedCheckBox?.on = false
        
        workPastThreeYearsOptionsView.deselectAllSelctions()
        
        incomeTF.text = ""
        marritalStatusOptions.deselectAllSelctions()
        livingArrangementsOptions.deselectAllSelctions()
        
        raceOptionsView.deselectAllSelctions()
        educationOptionsView.deselectAllSelctions()
        pastEmployement.deselectAllSelctions()
        
        commutingDistanceWithClinicOptionsGroup.selectedCheckBox?.on = false
        
        houseHoldOptionsView.deselectAllSelctions()
        
        goingToJailOptionsGroup.selectedCheckBox?.on = false
        
        commentsTextView.text = ""
        formCompletedByTF.text = ""
        investigatorSignatureTF.text = ""
        signDate.date = nil
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
}
