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

    @IBOutlet var scrollView: RUIScrollView!
    @IBOutlet var medicalHistoryTableView: RUITableView!
    @IBOutlet var medicalHistoryTableViewHeight: NSLayoutConstraint!
    
    @IBOutlet var haveMedicalProblemsStackView: RUIStackView!
    var haveMedicalProblemsOptionsGroup = BEMCheckBoxGroup()
    var haveMedicalProblems : Bool? = nil
    @IBOutlet var medicalStatusTableView: RUITableView!
    @IBOutlet var medicalStatuTableViewHeight: NSLayoutConstraint!
    
    @IBOutlet var feelingInThePast7Days: RUITextView!
    
    @IBOutlet var havePastProblemsStackView: RUIStackView!
    var havePastProblemsOptionsGroup = BEMCheckBoxGroup()
    var havePastProblems : Bool? = nil
    @IBOutlet var pastProblemsTableView: PastProblemsTableView!
    @IBOutlet var pastProblemsTableHeight: NSLayoutConstraint!
    
    @IBOutlet var haveTakenMedicationsStackView: RUIStackView!
    var haveTakenMedicationsOptionsGroup = BEMCheckBoxGroup()
    var haveTakenMedications : Bool? = nil
    @IBOutlet var takenMedicationsTableView: TakenMedicationsTableView!
    @IBOutlet var takenMedicationsTableHeight: NSLayoutConstraint!
    
    var medicalHistoryArray = [MedicalHistory]()
    var medicalStatusArray = [MedicalStatus]()
    
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
            objet.title = nil
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
        /*
        @IBOutlet var haveMedicalProblemsStackView: RUIStackView!
        var haveMedicalProblemsOptionsGroup = BEMCheckBoxGroup()
        var haveMedicalProblems : Bool? = nil
        @IBOutlet var medicalStatusTableView: RUITableView!
        @IBOutlet var medicalStatuTableViewHeight: NSLayoutConstraint!
        
        @IBOutlet var feelingInThePast7Days: RUITextView!
        
        @IBOutlet var havePastProblemsStackView: RUIStackView!
        var havePastProblemsOptionsGroup = BEMCheckBoxGroup()
        var havePastProblems : Bool? = nil
        @IBOutlet var pastProblemsTableView: PastProblemsTableView!
        @IBOutlet var pastProblemsTableHeight: NSLayoutConstraint!
        
        @IBOutlet var haveTakenMedicationsStackView: RUIStackView!
        var haveTakenMedicationsOptionsGroup = BEMCheckBoxGroup()
        var haveTakenMedications : Bool? = nil
        @IBOutlet var takenMedicationsTableView: TakenMedicationsTableView!
        @IBOutlet var takenMedicationsTableHeight: NSLayoutConstraint!
        
        var medicalHistoryArray = [MedicalHistory]()
        var medicalStatusArray = [MedicalStatus]()
        */
        
        configureLayout()
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

//MARK:- BEMCheckBoxDelegate Methods
extension FormTwoViewController : BEMCheckBoxDelegate {
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
            view.checkBox?.delegate = self
            haveMedicalProblemsOptionsGroup.addCheckBox(toGroup: view.checkBox!)
        }
    }
    
    func initializeHavePastProblemsStackView() {
        havePastProblemsOptionsGroup.mustHaveSelection = true
        for view in havePastProblemsStackView.arrangedSubviews as! [HorizontalOptionView] {
            view.checkBox?.delegate = self
            havePastProblemsOptionsGroup.addCheckBox(toGroup: view.checkBox!)
        }
    }
    
    func initializeHaveTakenMedicationsStackView() {
        haveTakenMedicationsOptionsGroup.mustHaveSelection = true
        for view in haveTakenMedicationsStackView.arrangedSubviews as! [HorizontalOptionView] {
            view.checkBox?.delegate = self
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
}
