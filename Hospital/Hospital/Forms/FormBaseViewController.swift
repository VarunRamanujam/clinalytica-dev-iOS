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
    
    @IBOutlet var headerView: FormHeaderView!
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
            self.perform(#selector(FormBaseViewController.selectedPageNumberChanged), with: nil, afterDelay: 0.2)
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
        
        self.view.endEditing(true)
        
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
        addViewController(at: sender.tag)
    }
    
    func selectedPageNumberChanged() {
        updatePageNumberButtons()
        
        if selectedPage == 4 {
            nextButton.setTitle("Submit", for: .normal)
        } else {
            nextButton.setTitle("Next", for: .normal)
        }
    }
    
    @IBAction func didPressClearButton(_ sender: RUIButton) {
        if formsStatus[selectedPage] != .Completed {
            childFormViewControllers[selectedPage].clearButtonClicked()
        }
    }
    
    @IBAction func didPressNextButton(_ sender: RUIButton) {

//        #if DEBUG
//        let powerBI = PowerBIWebViewController(nibName: "PowerBIWebViewController", bundle: nil)
//        self.navigationController?.pushViewController(powerBI, animated: true)
//            return
//        #endif
        
        if formsStatus[selectedPage] == .Completed {
            formSubmitted(sender: childFormViewControllers[selectedPage])
        } else {
            _ = childFormViewControllers[selectedPage].submitForm()
//            #if DEBUG
//                if status == false {
//                    formSubmitted(sender: childFormViewControllers[selectedPage])
//                }
//            #endif
        }
    }
}

//MARK:- FormViewControllerDelegate Menthods
extension FormBaseViewController : FormViewControllerDelegate {
    func formSubmitted(sender: FormViewController) {
        
        formsStatus[selectedPage] = .Completed
        
        if (selectedPage + 1) >= formsStatus.count {
            let powerBI = PowerBIWebViewController(nibName: "PowerBIWebViewController", bundle: nil)
            self.navigationController?.pushViewController(powerBI, animated: true)
            return
        }
        
        childFormViewControllers[selectedPage].beginAppearanceTransition(false, animated: false)
        childFormViewControllers[selectedPage].endAppearanceTransition()
        
        if formsStatus[selectedPage + 1] == .None {
            formsStatus[selectedPage + 1] = .Inprogresss
        }
        
        selectedPage += 1
        addViewController(at: selectedPage)
    }
}

//MARK:- Private Menthods
extension FormBaseViewController {
    func initializeFormBaseViewController() {
        
        bottomView.addBorder()
        
        childFormViewControllers = [FormOneViewController(nibName: "FormOneViewController", bundle: nil),
                                    FormTwoViewController(nibName: "FormTwoViewController", bundle: nil),
                                    FormThreeController(nibName: "FormThreeController", bundle: nil),
                                    FormFourViewController(nibName: "FormFourViewController", bundle: nil),
                                    FormFiveViewController(nibName: "FormFiveViewController", bundle: nil)]
        addViewController(at: 0)
        updatePageNumberButtons()
        updateBottomStackView()
        
//        #if DEBUG
            self.perform(#selector(FormBaseViewController.didTapOnPageNumberButton(_:)), with: pageNumberButtons[0], afterDelay: 0.5)
//        #endif

    }
    
    func addViewController(at index : Int) {
        
        let viewCnt = childFormViewControllers[index]
        
        if viewCnt.parent == nil {
            viewCnt.delegate = self
            self.addChildViewController(viewCnt)
            
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
            scrollView.setContentOffset(CGPoint(x: (CGFloat(index) * scrollView.frame.width), y: 0), animated: false)
        } else {
            
            viewCnt.beginAppearanceTransition(true, animated: true)
            scrollView.setContentOffset(CGPoint(x: (CGFloat(index) * scrollView.frame.width), y: 0), animated: true)
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
