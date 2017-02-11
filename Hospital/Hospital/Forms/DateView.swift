//
//  DateView.swift
//  Hospital
//
//  Created by Shridhar on 2/1/17.
//
//

import UIKit

protocol DateViewDelegate : class {
    func dateChanged(sender : DateView, newDate : Date)
}

class DateView: RUIView {

    @IBOutlet var monthLabel: RUILabel! //This is used for Hour if type is Time
    @IBOutlet var monthWidthConstraint: NSLayoutConstraint!
    @IBOutlet var dayLabel: RUILabel!//This is used for Minute if type is Time
    @IBOutlet var dayWidthConstraint: NSLayoutConstraint!
    @IBOutlet var yearLabel: RUILabel!
    
    var delegate : DateViewDelegate?
    
    @IBInspectable var isDateFormat: Bool = true //Set false for time format
    
    @IBInspectable var canChooseDate : Bool = true
    
    @IBInspectable var date : Date? {
        didSet {
            setDateLabels()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initializeDateView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initializeDateView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.addBorderAndCornerRadius()
    }
    
    func initializeDateView() {
        
        let view = UINib(nibName: "DateView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! UIView
        self.addSubview(view)
        installWrapContentLayoutConstraints(self, childView: view)
        
        self.clipsToBounds = true
        setDateLabels()

        if canChooseDate {
            self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(DateView.didTap)))
        }
        
        if isDateFormat == false {
            monthWidthConstraint = monthWidthConstraint.setMultiplier(multiplier: 0.5)
            dayWidthConstraint = dayWidthConstraint.setMultiplier(multiplier: 0.5)
            dayWidthConstraint.constant = -2 //This is for middle divider
        }
    }
    
    func didTap() {
        if canChooseDate == false {
            return
        }
        
        let datePickerCntl = DatePickerController(nibName: "DatePickerController", bundle: nil)
        datePickerCntl.date = date
        datePickerCntl.datePickerMode = isDateFormat ? .date : .time
        datePickerCntl.valueChanged = { (newDate : Date) in
            self.date = newDate
            self.delegate?.dateChanged(sender: self, newDate: self.date!)
        }
        datePickerCntl.modalPresentationStyle = .overFullScreen
        self.parentViewController()?.present(datePickerCntl, animated: true, completion: nil)
    }

    private func setDateLabels() {
        
        if isDateFormat {
            if date != nil {
                let formatter = DateFormatter()
                formatter.dateFormat = "MMM"
                monthLabel.text = formatter.string(from: date!)
                
                formatter.dateFormat = "dd"
                dayLabel.text = formatter.string(from: date!)
                
                formatter.dateFormat = "yyyy"
                yearLabel.text = formatter.string(from: date!)
            } else {
                monthLabel.text = "Mo"
                dayLabel.text = "Day"
                yearLabel.text = "Yr"
            }
        } else {
            
            if date != nil {
                let formatter = DateFormatter()
                formatter.dateFormat = "HH"
                monthLabel.text = formatter.string(from: date!)
                
                formatter.dateFormat = "mm"
                dayLabel.text = formatter.string(from: date!)
                
                yearLabel.text = ""
            } else {
                monthLabel.text = "HH"
                dayLabel.text = "mm"
                yearLabel.text = ""
            }
        }
    }
}
