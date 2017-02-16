//
//  MedicalHistoryAndStatusInfo.swift
//  Hospital
//
//  Created by Shridhar on 2/15/17.
//
//

import UIKit
import ObjectMapper

class CurrentMedicalProblems: NSObject, Mappable {
    
    var choice : Int!
    var medical_problems = [MedicalStatus]()
    
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        super.init()
    }
    
    func mapping(map: Map) {
        choice <- map["choice"]
        medical_problems <- map["medical_problems"]
    }
    
    func isValid() -> Bool {
        
        if choice == nil || choice == 0 {
            return false
        }
        
        if choice == 1 {
            for object in medical_problems {
                if object.isValid() == false {
                    return false
                }
            }
        }
        
        return true
    }
}

class MedicalStatus: NSObject, Mappable {
    
    var natureOfProblem : String!
    var eventCode : Int!
    var dateOfOnSet : String!
    var severity : Int!
    var ationTaken : Int!
    
    func clearData() {
        natureOfProblem = nil
        eventCode = nil
        dateOfOnSet = nil
        severity = nil
        ationTaken = nil
    }
    
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        super.init()
    }
    
    func mapping(map: Map) {
        natureOfProblem <- map["problem_nature"]
        eventCode <- map["medical_event_code"]
        dateOfOnSet <- map["date_onset"]
        severity <- map["severity"]
        ationTaken <- map["action_taken"]
    }
    
    func isValid() -> Bool {
        
        if isEmpty() {
            return true
        }
        
        if isEmptyString(string: natureOfProblem) ||
            isEmptyString(string: dateOfOnSet) {
            return false
        }
        
        if eventCode == nil || eventCode == 0 ||
            severity == nil || severity == 0 ||
            ationTaken == nil || ationTaken == 0 {
            return false
        }
        
        return true
    }
    
    func isEmpty() -> Bool {
        if isEmptyString(string: natureOfProblem) &&
            isEmptyString(string: dateOfOnSet) &&
            (eventCode == nil ||  eventCode == 0) &&
            (severity == nil ||  severity == 0) &&
            (ationTaken == nil ||  ationTaken == 0){
            return true
        }
        
        return false
    }
}

class ProblemsInThePast7daysInfo: NSObject, Mappable {
    
    var choice : Int!
    var problems = [PastProblem]()
    
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        super.init()
    }
    
    func mapping(map: Map) {
        choice <- map["choice"]
        problems <- map["problems"]
    }
    
    func isValid() -> Bool {
        
        if choice == nil || choice == 0 {
            return false
        }
        
        if choice == 1 {
            for object in problems {
                if object.isValid() == false {
                    return false
                }
            }
        }
        
        return true
    }
}

class MedicationsInThe7daysInfo: NSObject, Mappable {
    
    var choice : Int!
    var drug_usage = [Medication]()
    
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        super.init()
    }
    
    func mapping(map: Map) {
        choice <- map["choice"]
        drug_usage <- map["drug_usage"]
    }
    
    func isValid() -> Bool {
        
        if choice == nil || choice == 0 {
            return false
        }
        
        if choice == 1 {
            for object in drug_usage {
                if object.isValid() == false {
                    return false
                }
            }
        }
        
        return true
    }
}

class Medication: NSObject, Mappable {
    
    var drugName : String!
    var drugCode : String!
    var strength : Int!
    var dosesPerDay : Int!
    var codeIndication : Int!
    var startDate : String!
    var stopDate : String!
    var continueing : Int!
    
    func clearData() {
        drugName = nil
        drugCode = nil
        strength = nil
        dosesPerDay = nil
        codeIndication = nil
        startDate = nil
        stopDate = nil
        continueing = nil
    }
    
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        super.init()
    }
    
    func mapping(map: Map) {
        drugName <- map["drug_name"]
        drugCode <- map["drug_code"]
        strength <- map["strength"]
        dosesPerDay <- map["doses_per_day"]
        codeIndication <- map["code_indication"]
        startDate <- map["start_date"]
        stopDate <- map["stop_date"]
        continueing <- map["check"]
    }
    
    func isValid() -> Bool {
        if isEmpty() {
            return true
        }
        
        if isEmptyString(string: drugName) ||
            isEmptyString(string: drugCode) ||
            isEmptyString(string: startDate) ||
            isEmptyString(string: stopDate){
            return false
        }
        
        if strength == nil || strength == 0 ||
            dosesPerDay == nil || dosesPerDay == 0 ||
            codeIndication == nil || codeIndication == 0 ||
            continueing == nil || continueing == 0 {
            return false
        }
        
        return true
    }
    
    func isEmpty() -> Bool {
        return (isEmptyString(string: drugName) == true &&
            isEmptyString(string: drugCode) == true &&
            (strength == nil || strength == 0) &&
            (dosesPerDay == nil || dosesPerDay == 0) &&
            (codeIndication == nil || codeIndication == 0) &&
            isEmptyString(string: startDate) == true &&
            isEmptyString(string: stopDate) == true &&
            (continueing == nil || continueing == 0))
    }
}

class MedicalHistory: NSObject, Mappable {
    
    var title : String!
    var status : Int! = nil
    var medicalDescription : String!
    
    func clearData() {
        status = nil
        medicalDescription = nil
    }
    
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        super.init()
    }
    
    func mapping(map: Map) {
        title <- map["disease"]
        medicalDescription <- map["discription"]
    }
    
    func isValid() -> Bool {
        if status == nil || status == 0 {
            return false
        }
        
        if status! == 1 {
            return isEmptyString(string: medicalDescription) == false
        }
        
        return true
    }
}

class MedicalHistoryAndStatusInfo: NSObject, Mappable {
    
    var patient_initials : String!
    var study : String!
    var form_no : Int!
    var center : Int!
    var patient_number : Int!
    var vst_date : String!
    
    var q1Diseases = [MedicalHistory]()
    var q2MedicalProblems = CurrentMedicalProblems()
    var q3      : String!
    var q4ProblemsInThePast7daysInfo = ProblemsInThePast7daysInfo()
    var q5MedicationsInThe7daysInfo = MedicationsInThe7daysInfo()
    
    var completed_by     : String!
    var inv_date : String!
    
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
        center <- map["center_no"]
        patient_number <- map["patient_no"]
        vst_date <- map["vst_date"]
        q1Diseases <- map["q1"]
        q2MedicalProblems <- map["q2"]
        q3 <- map["q3"]
        q4ProblemsInThePast7daysInfo <- map["q4"]
        q5MedicationsInThe7daysInfo <- map["q5"]
        completed_by <- map["completed_by"]
        inv_date <- map["inv_date"]
    }
    
    func isValid() -> Bool {
        
        if isEmptyString(string: patient_initials) ||
            isEmptyString(string: study) ||
            isEmptyString(string: vst_date) ||
            isEmptyString(string: q3) ||
            isEmptyString(string: completed_by) ||
            isEmptyString(string: inv_date) {
            
            return false
        }
        
        if form_no == nil || form_no == 0 ||
            center == nil || center == 0 ||
            patient_number == nil || patient_number == 0 {
            return false
        }
        
        for obj in q1Diseases {
            if obj.isValid() == false {
                return false
            }
        }
        
        if q2MedicalProblems.isValid() == false ||
            q4ProblemsInThePast7daysInfo.isValid() == false ||
            q5MedicationsInThe7daysInfo.isValid() == false {
            return false
        }
        return true
    }
}
