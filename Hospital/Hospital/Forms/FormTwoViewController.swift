//
//  FormTwoViewController.swift
//  Hospital
//
//  Created by Shridhar on 2/1/17.
//
//

import UIKit
import BEMCheckBox

let MedicalHistoryAndStatusCellIdentifier = "MedicalHistoryAndStatusCellIdentifier"
let MedicalHistoryAndStatusTitleCellIdentifier = "MedicalHistoryAndStatusTitleCellIdentifier"
let MedicalStatusCellIdentifier = "MedicalStatusCellIdentifier"
let MedicalStatusTitleCellIdentifier = "MedicalStatusTitleCellIdentifier"

class FormTwoViewController: FormViewController {

    let formTwoInfo = MedicalHistoryAndStatusInfo()
    
    @IBOutlet var scrollView: RUIScrollView!
    @IBOutlet var medicalHistoryTableView: RUITableView!
    @IBOutlet var medicalHistoryTableViewHeight: NSLayoutConstraint!
    var medicalHistoryArray = [MedicalHistory]()
    
    @IBOutlet var haveMedicalProblemsStackView: RUIStackView!
    var haveMedicalProblemsOptionsGroup = BEMCheckBoxGroup()
    @IBOutlet var medicalStatusTableView: RUITableView!
    @IBOutlet var medicalStatuTableViewHeight: NSLayoutConstraint!
    @IBOutlet var medicalStatusMaskView: RUIView!
    var medicalStatusArray = [MedicalStatus]()
    var haveMedicalProblems : Bool? = nil {
        didSet {
            self.view.endEditing(true)
            if haveMedicalProblems == nil {
                medicalStatusMaskView.isHidden = false
            } else {
                medicalStatusMaskView.isHidden = true
            }
        }
    }
    
    @IBOutlet var feelingInThePast7Days: RUITextView!
    
    @IBOutlet var havePastProblemsStackView: RUIStackView!
    var havePastProblemsOptionsGroup = BEMCheckBoxGroup()
    @IBOutlet var pastProblemsTableView: PastProblemsTableView!
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
    
    @IBOutlet var haveTakenMedicationsStackView: RUIStackView!
    var haveTakenMedicationsOptionsGroup = BEMCheckBoxGroup()
    @IBOutlet var takenMedicationsTableView: TakenMedicationsTableView!
    @IBOutlet var takenMedicationsTableHeight: NSLayoutConstraint!
    @IBOutlet var takenMedicationsMaskView: RUIView!
    var haveTakenMedications : Bool? = nil {
        didSet {
            self.view.endEditing(true)
            if haveTakenMedications == nil {
                takenMedicationsMaskView.isHidden = false
            } else {
                takenMedicationsMaskView.isHidden = true
            }
        }
    }
    
    //BottomView
    @IBOutlet var formCompletedByTF: RUITextField!
    @IBOutlet var investigatorSignatureTF: RUITextField!
    @IBOutlet var signDate: DateView!
    
    private var tempCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initializeFormTwoViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        intializeNavigationBar()
    }
    
    override func clearButtonClicked() {
        
        for objet in medicalHistoryArray {
            objet.status = nil
            objet.medicalDescription = nil
        }
        medicalHistoryTableView.reloadData()
        
        for objet in medicalStatusArray {
            objet.natureOfProblem = nil
            objet.eventCode = nil
            objet.dateOfOnSet = nil
            objet.severity = nil
            objet.ationTaken = nil
        }
        medicalStatusTableView.reloadData()
        
        haveMedicalProblemsOptionsGroup.selectedCheckBox?.on = false
        haveMedicalProblems = nil
        
        feelingInThePast7Days.text = nil
        
        havePastProblemsOptionsGroup.selectedCheckBox?.on = false
        havePastProblems = nil
        
        pastProblemsTableView.clearData()
        
        haveTakenMedicationsOptionsGroup.selectedCheckBox?.on = false
        haveTakenMedications = nil
        
        takenMedicationsTableView.clearData()
        
        formCompletedByTF.text = nil
        investigatorSignatureTF.text = nil
        signDate.date = nil
        
        configureLayout()
    }
    
    override func submitForm() -> Bool {
        
        fectchModel()
        
        if formTwoInfo.isValid() == false {
            showAlrt(fromController: self, title: "Error", message: "Some fields are missing.", cancelText: "OK", cancelAction: nil, otherText: nil, action: nil)
            
            return true
        }
        
        sendRequestToSubmitFormTwo()
        
        return true
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        configureLayout()
    }
    
    func configureLayout() {
        updateHeightConstraint()
        
        self.perform(#selector(FormTwoViewController.updateHeightConstraint), with: nil, afterDelay: 0.3)
    }
    
    func updateHeightConstraint() {

        medicalHistoryTableViewHeight.constant = medicalHistoryTableView.contentSize.height - 6.0
        
        if haveMedicalProblems == nil || haveMedicalProblems! == true {
            medicalStatuTableViewHeight.constant = medicalStatusTableView.contentSize.height - 6.0
        } else {
            medicalStatuTableViewHeight.constant = 0.0
        }
        
        if havePastProblems == nil || havePastProblems! == true {
            pastProblemsTableHeight.constant = pastProblemsTableView.contentSize.height - 6.0
        } else {
            pastProblemsTableHeight.constant = 0.0
        }
        
        if haveTakenMedications == nil || haveTakenMedications! == true {
            takenMedicationsTableHeight.constant = takenMedicationsTableView.contentSize.height - 6.0
        } else {
            takenMedicationsTableHeight.constant = 0.0
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//MARK:- UITextFieldDelegate Methods
extension FormTwoViewController : UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let newStr = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
        
        if textField == formCompletedByTF || textField == investigatorSignatureTF {
            return newStr.length() < Text_Length
        }
        
        return true
    }
}
//MARK:- UITableViewDataSource
extension FormTwoViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == medicalHistoryTableView {
            return (medicalHistoryArray.count + 1)
        } else if tableView == medicalStatusTableView {
            return medicalStatusArray.count + 1
        }
       
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == medicalHistoryTableView {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: MedicalHistoryAndStatusTitleCellIdentifier, for: indexPath) as! MedicalHistoryAndStatusTitleCell
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: MedicalHistoryAndStatusCellIdentifier, for: indexPath) as! MedicalHistoryAndStatusCell
                cell.medicalHistoryData = medicalHistoryArray[indexPath.row - 1]
                return cell
            }
        } else if tableView == medicalStatusTableView {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: MedicalStatusTitleCellIdentifier, for: indexPath) as! MedicalStatusTitleCell
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: MedicalStatusCellIdentifier, for: indexPath) as! MedicalStatusCell
                cell.medicalStatus = medicalStatusArray[indexPath.row - 1]
                return cell
            }
        }
        
        return UITableViewCell()
    }
}

//MARK:- HorizontalOptionViewDelegate Methods
extension FormTwoViewController : HorizontalOptionViewDelegate {
    
    func didTap(sender: HorizontalOptionView, selected: Bool) {
        let stackChildViews = haveMedicalProblemsStackView.arrangedSubviews as! [HorizontalOptionView]
        let pastProblemChildViews = havePastProblemsStackView.arrangedSubviews as! [HorizontalOptionView]
        let takenMedicationsChildView = haveTakenMedicationsStackView.arrangedSubviews as! [HorizontalOptionView]
        if sender == stackChildViews[0] {
            //Yes
            haveMedicalProblems = true
        } else if sender == stackChildViews[1] {
            //NO
            haveMedicalProblems = false
        } else if sender == pastProblemChildViews[0] {
            //Yes
            havePastProblems = true
        } else if sender == pastProblemChildViews[1] {
            //NO
            havePastProblems = false
        } else if sender == takenMedicationsChildView[0] {
            //Yes
            haveTakenMedications = true
        } else if sender == takenMedicationsChildView[1] {
            //NO
            haveTakenMedications = false
        }
        
        updateHeightConstraint()
    }
    
    func didTap(_ checkBox: BEMCheckBox) {
        let stackChildViews = haveMedicalProblemsStackView.arrangedSubviews as! [HorizontalOptionView]
        let pastProblemChildViews = havePastProblemsStackView.arrangedSubviews as! [HorizontalOptionView]
        let takenMedicationsChildView = haveTakenMedicationsStackView.arrangedSubviews as! [HorizontalOptionView]
        if checkBox == stackChildViews[0].checkBox {
            //Yes
            haveMedicalProblems = true
        } else if checkBox == stackChildViews[1].checkBox {
            //NO
            haveMedicalProblems = false
        } else if checkBox == pastProblemChildViews[0].checkBox {
            //Yes
            havePastProblems = true
        } else if checkBox == pastProblemChildViews[1].checkBox {
            //NO
            havePastProblems = false
        } else if checkBox == takenMedicationsChildView[0].checkBox {
            //Yes
            haveTakenMedications = true
        } else if checkBox == takenMedicationsChildView[1].checkBox {
            //NO
            haveTakenMedications = false
        }
        
        updateHeightConstraint()
    }
}
//MARK:- Private Methods
extension FormTwoViewController {
    
    func intializeNavigationBar() {
        self.parent?.title = "MEDICAL HISTORY AND STATUS"
    }
    
    func initializeFormTwoViewController() {
        
        createModel()
        intialzeTableView()
        initializehaveMedicalProblemsStackView()
        initializeHavePastProblemsStackView()
        initializeHaveTakenMedicationsStackView()
    }
    
    private func intialzeTableView() {
        medicalHistoryTableView.addBorderAndCornerRadius()
        medicalHistoryTableView.register(UINib(nibName: "MedicalHistoryAndStatusCell",
                                               bundle: nil),
                                         forCellReuseIdentifier: MedicalHistoryAndStatusCellIdentifier)
        
        medicalHistoryTableView.register(UINib(nibName: "MedicalHistoryAndStatusTitleCell",
                                               bundle: nil),
                                         forCellReuseIdentifier: MedicalHistoryAndStatusTitleCellIdentifier)
        medicalHistoryTableView.rowHeight = UITableViewAutomaticDimension
        medicalHistoryTableView.estimatedRowHeight = 80.0
        
        medicalStatusTableView.addBorderAndCornerRadius()
        medicalStatusTableView.register(UINib(nibName: "MedicalStatusCell",
                                              bundle: nil),
                                        forCellReuseIdentifier: MedicalStatusCellIdentifier)
        medicalStatusTableView.register(UINib(nibName: "MedicalStatusTitleCell",
                                              bundle: nil),
                                        forCellReuseIdentifier: MedicalStatusTitleCellIdentifier)
        medicalStatusTableView.rowHeight = UITableViewAutomaticDimension
        medicalStatusTableView.estimatedRowHeight = 80.0
    }
    
    func initializehaveMedicalProblemsStackView() {
        haveMedicalProblemsOptionsGroup.mustHaveSelection = true
        for view in haveMedicalProblemsStackView.arrangedSubviews as! [HorizontalOptionView] {
            view.delegate = self
            haveMedicalProblemsOptionsGroup.addCheckBox(toGroup: view.checkBox!)
        }
    }
    
    func initializeHavePastProblemsStackView() {
        havePastProblemsOptionsGroup.mustHaveSelection = true
        for view in havePastProblemsStackView.arrangedSubviews as! [HorizontalOptionView] {
            view.delegate = self
            havePastProblemsOptionsGroup.addCheckBox(toGroup: view.checkBox!)
        }
    }
    
    func initializeHaveTakenMedicationsStackView() {
        haveTakenMedicationsOptionsGroup.mustHaveSelection = true
        for view in haveTakenMedicationsStackView.arrangedSubviews as! [HorizontalOptionView] {
            view.delegate = self
            haveTakenMedicationsOptionsGroup.addCheckBox(toGroup: view.checkBox!)
        }
    }
    
    private func createModel() {
        
        for title in MedicalHistoryOptions {
            let med = MedicalHistory()
            med.title = title
            medicalHistoryArray.append(med)
        }
        
        for _ in 0..<6 {
            let statusObj = MedicalStatus()
            medicalStatusArray.append(statusObj)
        }
    }
    
    func fectchModel() {
        formTwoInfo.patient_initials = FormHeaderInfo.shared.patient_initials
        formTwoInfo.study = FormHeaderInfo.shared.study
        formTwoInfo.form_no = FormHeaderInfo.shared.form_no
        formTwoInfo.center = FormHeaderInfo.shared.center
        formTwoInfo.patient_number = FormHeaderInfo.shared.patient_number
        formTwoInfo.vst_date = FormHeaderInfo.shared.vst_date?.getString()
        
        formTwoInfo.q1Diseases = medicalHistoryArray
        
        formTwoInfo.q2MedicalProblems.choice = getNumberFromBool(value: haveMedicalProblems)
        if formTwoInfo.q2MedicalProblems.choice != nil &&
        formTwoInfo.q2MedicalProblems.choice == 1 {
            formTwoInfo.q2MedicalProblems.medical_problems = medicalStatusArray
        } else {
            formTwoInfo.q2MedicalProblems.medical_problems.removeAll()
        }
        
        
        formTwoInfo.q3 = feelingInThePast7Days.text
        
        formTwoInfo.q4ProblemsInThePast7daysInfo.choice = getNumberFromBool(value: havePastProblems)
        if formTwoInfo.q4ProblemsInThePast7daysInfo.choice != nil &&
            formTwoInfo.q4ProblemsInThePast7daysInfo.choice == 1 {
            formTwoInfo.q4ProblemsInThePast7daysInfo.problems = pastProblemsTableView.pastProbles
        } else {
            formTwoInfo.q4ProblemsInThePast7daysInfo.problems.removeAll()
        }
        
        formTwoInfo.q5MedicationsInThe7daysInfo.choice = getNumberFromBool(value: haveTakenMedications)
        if formTwoInfo.q5MedicationsInThe7daysInfo.choice != nil &&
            formTwoInfo.q5MedicationsInThe7daysInfo.choice == 1 {
            formTwoInfo.q5MedicationsInThe7daysInfo.drug_usage = takenMedicationsTableView.medications
        } else {
            formTwoInfo.q5MedicationsInThe7daysInfo.drug_usage.removeAll()
        }
        formTwoInfo.completed_by = formCompletedByTF.text
        formTwoInfo.inv_date = signDate.date?.getString()
    }
    
    func getNumberFromBool(value : Bool?) -> Int? {
        if value == nil {
            return nil
        }
        
        return value! ? 1 : 2
    }
    
    func sendRequestToSubmitFormTwo() {
        
        if appDelegate.hasConnectivity() == false {
            appDelegate.showMessageHudWithMessage(message: NoInternetAccess, delay: 2.0)
            return
        }
        
        appDelegate.showProgressHudForViewMy(withDetailsLabel: "Please wait…", labelText: "Requesting")
        appManager.sendRequestToSubmitFormTwo(formTwoObject: formTwoInfo) { (response) in
            
            appDelegate.hideProgressHudInView()
            
            if response != nil && response!.isSuccess() {
                self.delegate?.formSubmitted(sender: self)
            } else {
                showAlrt(fromController: self, title: "Error", message: response?.statusMessage ?? ServerError, cancelText: "OK", cancelAction: nil, otherText: nil, action: nil)
            }
        }
    }
}
