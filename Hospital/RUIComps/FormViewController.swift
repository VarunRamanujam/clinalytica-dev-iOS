//
//  FormViewController.swift
//  Hospital
//
//  Created by Shridhar on 2/1/17.
//
//

import UIKit

protocol FormViewControllerDelegate : class {
    func formSubmitted(sender : FormViewController)
}

class FormViewController: RUIViewController {

    var delegate : FormViewControllerDelegate?
    
    var appManager = AppManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func clearButtonClicked() {
        
    }
    
    func submitForm() -> Bool {
        return false
    }
}
