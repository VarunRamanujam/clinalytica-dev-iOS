//
//  FormFourViewController.swift
//  Hospital
//
//  Created by Shridhar on 2/1/17.
//
//

import UIKit

class FormFourViewController: FormViewController {

    @IBOutlet var oneToFiveQuestionsStackView: RUIStackView!
    @IBOutlet var sixToSixteenQuestionsStackView: RUIStackView!
    @IBOutlet var seventeenthQuestion: QuestionYesOrNoView!
    
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
        
        for view in sixToSixteenQuestionsStackView.arrangedSubviews {
            sixToSixteenQuestionsStackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
        
        for i in 6...16 {
            let questionView = QuestionYesOrNoView(frame: CGRect(x: 0, y: 0, width: sixToSixteenQuestionsStackView.frame.width, height: 30))
            questionView.title = StudyAdmissionQuestions[i-1]
            questionView.serialNumber = i
            sixToSixteenQuestionsStackView.addArrangedSubview(questionView)
        }
        
        seventeenthQuestion.title = StudyAdmissionQuestions[17-1]
        seventeenthQuestion.serialNumber = 17
    }
}
