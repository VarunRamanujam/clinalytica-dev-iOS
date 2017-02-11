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

    @IBOutlet var studyWeekNumbetTF: RUITextField!
    @IBOutlet var fromDateView: DateView!
    @IBOutlet var toDateView: DateView!
    
    @IBOutlet var haveYouBeenFeelingTextView: RUITextView!
    
    @IBOutlet var havePastProblemsStackView: RUIStackView!
    var havePastProblemsOptionsGroup = BEMCheckBoxGroup()
    var havePastProblems : Bool? = nil
    @IBOutlet var pastProblemsTableView: PastProblemsForm16TableView!
    @IBOutlet var pastProblemsTableHeight: NSLayoutConstraint!
    
    
    @IBOutlet var adviceForm17StackView: RUIStackView!
    var adviceForm17OptionsGroup = BEMCheckBoxGroup()
    var haveAdviceForm17 : Bool? = nil
    
    @IBOutlet var randomizationStackView: RUIStackView!
    var randomizationOptionsGroup = BEMCheckBoxGroup()
    var haveRandomization : Bool? = nil
    
    
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FormFiveViewController : BEMCheckBoxDelegate{
    func didTap(_ checkBox: BEMCheckBox) {
        let pastProblemChildViews = havePastProblemsStackView.arrangedSubviews as! [HorizontalOptionView]
        if checkBox == pastProblemChildViews[0].checkBox {
            //Yes
            havePastProblems = true
        } else if checkBox == pastProblemChildViews[1].checkBox {
            //NO
            havePastProblems = false
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
            view.checkBox?.delegate = self
            havePastProblemsOptionsGroup.addCheckBox(toGroup: view.checkBox!)
        }
    }

    func initializeAdviceForm17O() {
        adviceForm17OptionsGroup.mustHaveSelection = true
        for view in adviceForm17StackView.arrangedSubviews as! [HorizontalOptionView] {
            view.checkBox?.delegate = self
            adviceForm17OptionsGroup.addCheckBox(toGroup: view.checkBox!)
        }
    }
    
    func initializeRandomizationStackView() {
        randomizationOptionsGroup.mustHaveSelection = true
        for view in randomizationStackView.arrangedSubviews as! [HorizontalOptionView] {
            view.checkBox?.delegate = self
            randomizationOptionsGroup.addCheckBox(toGroup: view.checkBox!)
        }
    }
}
