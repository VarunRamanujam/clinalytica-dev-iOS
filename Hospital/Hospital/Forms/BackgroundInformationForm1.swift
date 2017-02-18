//
//  BackgroundInformation.swift
//  Hospital
//
//  Created by Shridhar on 2/13/17.
//
//

import UIKit
import ObjectMapper

class BackgroundInformationForm1: NSObject, Mappable {
    
    var patient_initials : String!
    var study : String!
    var form_no : Int!
    var center : Int!
    var patient_number : Int!
    var vst_date : String!
    var current_address     : String!
    var zip_code            : String!
    var work_phone          : String!
    var home_phone          : String!
    var dob     : String!
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
    var comments     : String!
    var completed_by     : String!
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
        center <- map["center_no"]
        patient_number <- map["patient_no"]
        vst_date <- map["vst_date"]
        current_address <- map["current_address"]
        zip_code <- map["zip_code"]
        work_phone <- map["work_phone"]
        home_phone <- map["home_phone"]
        dob <- map["dob"]
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
        comments <- map["comments"]
        completed_by <- map["completed_by"]
        date_of_inv <- map["date_of_inv"]
    }
    
    func isValid() -> (Bool, String) {
        
        if isEmptyString(string: patient_initials) ||
           isEmptyString(string: study) ||
            isEmptyString(string: vst_date) ||
            isEmptyString(string: current_address) ||
            isEmptyString(string: zip_code) ||
            isEmptyString(string: work_phone) ||
            isEmptyString(string: home_phone) ||
            isEmptyString(string: dob) ||
            isEmptyString(string: comments) ||
            isEmptyString(string: completed_by) ||
            isEmptyString(string: date_of_inv) {
            return (false, ErrorMissingFields)
        }
        
        if form_no == nil || form_no == 0 ||
            center == nil || center == 0 ||
            patient_number == nil || patient_number == 0 ||
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
            q12 == nil || q12 == 0
            {
            return (false, ErrorMissingFields)
        }
        
        if work_phone.length() != 10 {
            return (false, ErrorWorkPhoneField)
        }
        
        if home_phone.length() != 10 {
            return (false, ErrorHomePhoneField)
        }
        
        return (true, "")
    }
}
