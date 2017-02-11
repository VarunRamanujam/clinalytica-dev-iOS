//
//  FormBaseViewController.swift
//  Hospital
//
//  Created by Shridhar on 2/1/17.
//
//

import UIKit

enum FormStatus {
    case None
    case Inprogresss
    case Completed
}

class FormBaseViewController: RUIViewController {
    
    @IBOutlet var pageNumbersStackView: UIStackView!
    @IBOutlet var pageNumberButtons: [UIButton]!
    @IBOutlet var pageNumberDividers: [UIView]!
    
    @IBOutlet var scrollView: UIScrollView!
    
    @IBOutlet var scrollContentStackView: UIStackView!
    
    @IBOutlet var bottomView: UIView!
    @IBOutlet var bottomButtonsStackView: RUIStackView!
    
    @IBOutlet var clearButton: RUIButton!
    @IBOutlet var nextButton: RUIButton!
    
    
    var childFormViewControllers = [FormViewController]()
    var formsStatus = [FormStatus.Inprogresss, FormStatus.None, FormStatus.None, FormStatus.None, FormStatus.None]
    
    var selectedPage = 0 {
        didSet {
            updatePageNumberButtons()
            
            if selectedPage == 4 {
                nextButton.setTitle("Submit", for: .normal)
            } else {
                nextButton.setTitle("Next", for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeFormBaseViewController()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.setContentOffset(CGPoint(x: (CGFloat(selectedPage) * scrollView.frame.width), y: 0), animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//MARK:- UIScrollViewDelegate
extension FormBaseViewController : UIScrollViewDelegate {
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        childFormViewControllers[selectedPage].endAppearanceTransition()
    }
}

//MARK:- Button Actions
extension FormBaseViewController {
    @IBAction func didTapOnPageNumberButton(_ sender: UIButton) {
        
        if selectedPage == sender.tag {
            return
        }
        
        var lastCompletedPage = 0
        for i in 0..<formsStatus.count {
            if formsStatus[i] != .None {
                lastCompletedPage = i
            } else {
                break
            }
        }
        
        if sender.tag > lastCompletedPage {
            return
        }
        
        childFormViewControllers[selectedPage].beginAppearanceTransition(false, animated: false)
        childFormViewControllers[selectedPage].endAppearanceTransition()
        
        selectedPage = sender.tag
        childFormViewControllers[selectedPage].beginAppearanceTransition(true, animated: true)
        scrollView.setContentOffset(CGPoint(x: (CGFloat(selectedPage) * scrollView.frame.width), y: 0), animated: true)
    }
    
    @IBAction func didPressClearButton(_ sender: RUIButton) {
        childFormViewControllers[selectedPage].clearButtonClicked()
    }
    
    @IBAction func didPressNextButton(_ sender: RUIButton) {
        

        if (selectedPage + 1) >= formsStatus.count {
            return
        }
        
        formsStatus[selectedPage] = .Completed
        childFormViewControllers[selectedPage].beginAppearanceTransition(false, animated: false)
        childFormViewControllers[selectedPage].endAppearanceTransition()
        
        formsStatus[selectedPage + 1] = .Inprogresss
        selectedPage += 1
        
        childFormViewControllers[selectedPage].beginAppearanceTransition(true, animated: true)
        scrollView.setContentOffset(CGPoint(x: (CGFloat(selectedPage) * scrollView.frame.width), y: 0), animated: true)
    }
}

//MARK:- Private Menthods
extension FormBaseViewController {
    func initializeFormBaseViewController() {
        
        bottomView.addBorder()
        
        addChildViewControllers()
        updatePageNumberButtons()
        updateBottomStackView()
        
        #if DEBUG
//            self.perform(#selector(FormBaseViewController.didTapOnPageNumberButton(_:)), with: pageNumberButtons[4], afterDelay: 2.0)
        #endif

    }
    
    private func addChildViewControllers() {
        let viewCntls = [FormOneViewController(nibName: "FormOneViewController", bundle: nil),
                         FormTwoViewController(nibName: "FormTwoViewController", bundle: nil),
                         FormThreeController(nibName: "FormThreeController", bundle: nil),
                         FormFourViewController(nibName: "FormFourViewController", bundle: nil),
                         FormFiveViewController(nibName: "FormFiveViewController", bundle: nil)]
        for viewCnt in viewCntls {
            self.addChildViewController(viewCnt)
            childFormViewControllers.append(viewCnt)
            scrollContentStackView.addArrangedSubview(viewCnt.view)
            viewCnt.didMove(toParentViewController: self)
            let widthConstr = NSLayoutConstraint(item: viewCnt.view,
                                                 attribute: NSLayoutAttribute.width,
                                                 relatedBy: NSLayoutRelation.equal,
                                                 toItem: self.view,
                                                 attribute: NSLayoutAttribute.width,
                                                 multiplier: 1.0,
                                                 constant: 0.0)
            self.view.addConstraint(widthConstr)
        }
    }
    
    func updatePageNumberButtons() {
        var i = 0
        for button in pageNumberButtons {
            var pageNumberDivider : UIView?
            if i > 0 {
                pageNumberDivider = pageNumberDividers[i-1]
            }
            
            button.makeCircle()
            
            switch formsStatus[i] {
            case .None:
                button.backgroundColor = UIColor(red: 181, green: 200, blue: 209)
                pageNumberDivider?.backgroundColor = UIColor(red: 242, green: 242, blue: 242)
                break
            case .Inprogresss, .Completed:
                button.backgroundColor = UIColor(red: 72, green: 194, blue: 64)
                pageNumberDivider?.backgroundColor = UIColor(red: 72, green: 194, blue: 64)
                break
            }
            
            i += 1;
        }
    }
    
    func updateBottomStackView() {
        
        for button in bottomButtonsStackView.arrangedSubviews {
            button.addCornerRadius()
        }
    }
}
