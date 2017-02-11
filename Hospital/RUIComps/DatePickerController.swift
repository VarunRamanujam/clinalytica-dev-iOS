//
//  DatePickerController.swift
//  VIY
//
//  Created by Shridhar on 7/9/16.
//  Copyright © 2016 costrategix. All rights reserved.
//

import UIKit

class DatePickerController: UIViewController {
    
    @IBOutlet var datePicker: UIDatePicker!
    
    var valueChanged : ((_ newDate : Date) -> Void)?
    
    var date : Date? = Date()
    var datePickerMode: UIDatePickerMode = .date
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if date != nil {
            datePicker.date = date!
        }
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(DatePickerController.didChangeDate), for: .valueChanged)
        
        datePicker.datePickerMode = datePickerMode
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didChangeDate() {
        
    }

    @IBAction func doneButtonClicked(sender: AnyObject) {
        valueChanged?(datePicker.date)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dismissViewController(sender: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
}
