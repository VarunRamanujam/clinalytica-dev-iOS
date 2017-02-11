//
//  MedicalHistory.swift
//  Hospital
//
//  Created by Shridhar on 2/3/17.
//
//

import UIKit

class MedicalHistory: NSObject {
    
    var title : String!
    var status : Bool! = nil
    var medicalDescription : String!
}

class MedicalStatus: NSObject {
    
    var natureOfProblem : String!
    var eventCode : String!
    var dateOfOnSet : Date!
    var severity : Int!
    var ationTaken : Int!
}

class PastProblem: NSObject {
    
    var natureOfIllness : String!
    var eventCode : String!
    var dateOfOnSet : Date!
    var dateOfResolution : Date!
    var severity : Int!
    var ationTaken : Int!
    var outCome : Int!
}

class Medication: NSObject {
    
    var drugName : String!
    var drugCode : String!
    var strength : String!
    var dosesPerDay : String!
    var codeIndication : String!
    var startDate : Date!
    var stopDate : Date!
    var continueing : Bool!
}

class PastProblemForm16: PastProblem {
    var tyoeOfReport : Int!
    var relatedness : Int!
}
