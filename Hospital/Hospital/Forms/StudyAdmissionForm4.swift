//
//  StudyAdmissionForm11.swift
//  Hospital
//
//  Created by Shridhar on 2/13/17.
//
//

import UIKit
import ObjectMapper


class StudyAdmissionForm4: NSObject, Mappable {
    
    var patient_initials : String!
    var study : String!
    var form_no : Int!
    var center_no : Int!
    var patient_number : Int!
    var vst_date : String!
    var q1      : Int!
    var q2      : Int!
    var q3      : Int!
    var q4      : Int!
    var q5      : Int!
    var q6      : Int!
    var q7      : Int!
    var q8      : Int!
    var q9      : Int!
    var q10     : Int!
    var q11     : Int!
    var q12     : Int!
    var q13     : Int!
    var q14     : Int!
    var q15     : Int!
    var q16     : Int!
    var q16_spec: String!
    var q17     = Dates()
    var completed_by: String!
    var date_of_inv : String!
    
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
        q1 <- map["q1"]
        q2 <- map["q2"]
        q3 <- map["q3"]
        q4 <- map["q4"]
        q5 <- map["q5"]
        q6 <- map["q6"]
        q7 <- map["q7"]
        q8 <- map["q8"]
        q9 <- map["q9"]
        q10 <- map["q10"]
        q11 <- map["q11"]
        q12 <- map["q12"]
        q13 <- map["q13"]
        q14 <- map["q14"]
        q15 <- map["q15"]
        q16 <- map["q16"]
        q16_spec <- map["q16_spec"]
        q17 <- map["q17"]
        completed_by <- map["completed_by"]
        date_of_inv <- map["date_of_inv"]
    }
    
    func isValid() -> Bool {
        
        if isEmptyString(string: patient_initials) ||
            isEmptyString(string: study) ||
            isEmptyString(string: vst_date) ||
            isEmptyString(string: completed_by) ||
            isEmptyString(string: date_of_inv) {
            return false
        }
        
        if form_no == nil || form_no == 0 ||
            center_no == nil || center_no == 0 ||
            patient_number == nil || patient_number == 0 ||
            q1 == nil || q1 == 0 ||
            q2 == nil || q2 == 0 ||
            q3 == nil || q3 == 0 ||
            q4 == nil || q4 == 0 ||
            q5 == nil || q5 == 0 ||
            q6 == nil || q6 == 0 ||
            q7 == nil || q7 == 0 ||
            q8 == nil || q8 == 0 ||
            q9 == nil || q9 == 0 ||
            q10 == nil || q10 == 0 ||
            q11 == nil || q11 == 0 ||
            q12 == nil || q12 == 0 ||
            q13 == nil || q13 == 0 ||
            q14 == nil || q14 == 0 ||
            q15 == nil || q15 == 0 {
            return false
        }
        
        if isEmptyString(string: q16_spec) == false {
            if q16 == nil || q16 == 0 {
                return false
            }
        }
        
        if q17.isValid() == false {
            return false
        }
        
        return true
    }
}

class Dates: NSObject, Mappable {
    
    var main : Int!
    
    var date_randomized : String!
    var date_frstdose : String!
    
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        super.init()
    }
    
    func mapping(map: Map) {
        main <- map["main"]
        date_randomized <- map["a"]
        date_frstdose <- map["b"]
    }
    
    func isValid() -> Bool {
        return (main != nil && main != 0 &&
            isEmptyString(string: date_randomized) == false &&
            isEmptyString(string: date_frstdose) == false)
    }
}

/*{"patient_initials":"String","study": "String","form_no": 1,"center": 1,"patient": 1,"vst_date": 1,"std_week_no": 1,"from_date": {"mo":2,"day":14,"yr":2017},"to_date": {"mo":2,"day":14,"yr":2017},"q1": 1,"q2": {"choice": 1,"adverse_events": [{"event_nature": "String","event_code": 1,"date_onset": {"mo":2,"day":14,"yr":2017},"date_resolution": {"mo":2,"day":14,"yr":2017},"report_type": 1,"relatedness": 1,"serverity": 1,"action": 1,"outcome": 1},{"event_nature": "String","event_code": 1,"date_onset": {"mo":2,"day":14,"yr":2017},"date_resolution": {"mo":2,"day":14,"yr":2017},"report_type": 1,"relatedness": 1,"serverity": 1,"action": 1,"outcome": 1}]},"q3": 1,"q4": 1,"comments": "String","completed_by": "String","inv_date":{"mo":2,"day":14,"yr":2017}}
*/
