//
//  AdverseEventsForm5.swift
//  Hospital
//
//  Created by Shridhar on 2/14/17.
//
//

import UIKit
import ObjectMapper

class AdverseEventsForm5: NSObject, Mappable {
    
    var patient_initials : String!
    var study : String!
    var form_no : Int!
    var center_no : Int!
    var patient_number : Int!
    var vst_date : String!
    var std_week_no : Int!
    var from_date : String!
    var to_date : String!
    var q1 : String!
    var q2 = PastProblemsInfo()
    var q3 : Int!
    var q4 : Int!
    var comments : String!
    var completed_by : String!
    var inv_date : String!
    
    func isValid() -> Bool {
        
        if isEmptyString(string: patient_initials) ||
            isEmptyString(string: study) ||
            isEmptyString(string: vst_date) ||
            isEmptyString(string: from_date) ||
            isEmptyString(string: to_date) ||
            isEmptyString(string: q1) ||
            isEmptyString(string: comments) ||
            isEmptyString(string: completed_by) ||
            isEmptyString(string: inv_date) {
            return false
        }
        
        if form_no == nil || form_no == 0 ||
            center_no == nil || center_no == 0 ||
            patient_number == nil || patient_number == 0 ||
            q3 == nil || q3 == 0 ||
            q4 == nil || q4 == 0 {
            return false
        }
        
        if q2.isValid() == false {
            return false
        }
        
        return true
    }
    
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        super.init()
    }
    
    func mapping(map: Map) {
        patient_initials <- map["patient_initials"]
        study <- map["study"]
        form_no <- map["form_no"]
        center_no <- map["center_no"]
        patient_number <- map["patient_no"]
        vst_date <- map["vst_date"]
        std_week_no <- map["std_week_no"]
        from_date <- map["from_date"]
        to_date <- map["to_date"]
        q1 <- map["q1"]
        q2 <- map["q2"]
        q3 <- map["q3"]
        q4 <- map["q4"]
        comments <- map["comments"]
        completed_by <- map["completed_by"]
        inv_date <- map["inv_date"]
    }
    
    
}

class PastProblemsInfo: NSObject, Mappable{
   
    var choice: Int!
    var adverse_events = [PastProblemForm16]()
    
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        super.init()
    }
    
    func mapping(map: Map) {
        choice <- map["choice"]
        adverse_events <- map["adverse_events"]
    }
    
    func isValid() -> Bool {
        if choice == nil || choice == 0 {
            return false
        }
        
        if choice == 1 {
            for object in adverse_events {
                let isEmpty = object.isEmpty()
                if isEmpty == false{
                    if object.isValid() == false {
                        return false
                    }
                }
            }
        }
        
        return true
    }
}

class PastProblem: NSObject, Mappable {
    
    var natureOfIllness : String!
    var eventCode : Int!
    var dateOfOnSet : String!
    var dateOfResolution : String!
    var severity : Int!
    var ationTaken : Int!
    var outCome : Int!
    
    func clearData() {
        natureOfIllness = nil
        eventCode = nil
        dateOfOnSet = nil
        dateOfResolution = nil
        severity = nil
        ationTaken = nil
        outCome = nil
    }
    
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        super.init()
    }
    
    func mapping(map: Map) {
        natureOfIllness <- map["problem_nature"]
        eventCode <- map["medical_event_code"]
        dateOfOnSet <- map["date_onset"]
        dateOfResolution <- map["date_resolution"]
        severity <- map["serverity"]
        ationTaken <- map["action"]
        outCome <- map["action_taken"]
    }
    
    func isValid() -> Bool {
        if isEmpty() {
            return true
        }
        
        if isEmptyString(string: natureOfIllness) ||
            isEmptyString(string: dateOfOnSet) ||
            isEmptyString(string: dateOfResolution) {
            return false
        }
        
        if eventCode == nil || eventCode == 0 ||
            severity == nil || severity == 0 ||
            ationTaken == nil || ationTaken == 0 ||
            outCome == nil || outCome == 0 {
            return false
        }
        
        return true
    }
    
    func isEmpty() -> Bool {
        
        return (isEmptyString(string: natureOfIllness) == true &&
        (eventCode == nil || eventCode == 0) &&
        isEmptyString(string: dateOfOnSet) == true &&
        isEmptyString(string: dateOfResolution) == true &&
        (severity == nil || severity == 0) &&
        (ationTaken == nil || ationTaken == 0) &&
        (outCome == nil || outCome == 0))
    }
}

class PastProblemForm16: PastProblem {
    
    var typeOfReport : Int!
    var relatedness : Int!
    
    override func clearData() {
        super.clearData()
        typeOfReport = nil
        relatedness = nil
    }
    
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        natureOfIllness <- map["event_nature"]
        eventCode <- map["event_code"]
        dateOfOnSet <- map["date_onset"]
        dateOfResolution <- map["date_resolution"]
        severity <- map["serverity"]
        ationTaken <- map["action"]
        outCome <- map["outcome"]
        typeOfReport <- map["report_type"]
        relatedness <- map["relatedness"]
    }
    
    override func isValid() -> Bool {
        if isEmpty() {
            return true
        }
        
        let valid = super.isValid()
        if valid {
            return (typeOfReport != nil &&
                typeOfReport != 0 &&
                relatedness != nil &&
                relatedness != 0)
        }
        
        return false
    }
    
    override func isEmpty() -> Bool {
        return (super.isEmpty() &&
            (typeOfReport == nil || typeOfReport == 0) &&
            (relatedness == nil || relatedness == 0))
    }
}


