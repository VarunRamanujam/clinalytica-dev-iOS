//
//  LaboratoryReportForm3.swift
//  Hospital
//
//  Created by Shridhar on 2/16/17.
//
//

import UIKit
import ObjectMapper

class HematologyInfo: NSObject, Mappable {
    
    var total_wbc : Int!
    var total_rbc : Int!
    var platelet_count : Int!
    var hemoglobin : Int!
    var hematocrit : Int!
    var neutrophils : Int!
    var lymphocytes : Int!
    var monocytes : Int!
    var eosinophils : Int!
    var basophils : Int!
    
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        super.init()
    }
    
    func mapping(map: Map) {
        total_wbc <- map["total_wbc"]
        total_rbc <- map["total_rbc"]
        platelet_count <- map["platelet_count"]
        hemoglobin <- map["hemoglobin"]
        hematocrit <- map["hematocrit"]
        neutrophils <- map["neutrophils"]
        lymphocytes <- map["lymphocytes"]
        monocytes <- map["monocytes"]
        eosinophils <- map["eosinophils"]
        basophils <- map["basophils"]
    }
    
    func isValid() -> Bool {
        
        if total_wbc == nil || total_wbc == 0 ||
            total_rbc == nil || total_rbc == 0 ||
            platelet_count == nil || platelet_count == 0 ||
            hemoglobin == nil || hemoglobin == 0 ||
            hematocrit == nil || hematocrit == 0 ||
            neutrophils == nil || neutrophils == 0 ||
            lymphocytes == nil || lymphocytes == 0 ||
            monocytes == nil || monocytes == 0 ||
            eosinophils == nil || eosinophils == 0 ||
            basophils == nil || basophils == 0 {
            return false
        }
        
        return true
    }
}

class BloodChemistryInfo: NSObject, Mappable {
    
    var glucose : Int!
    var total_protein : Int!
    var albumin : Int!
    var bun : Int!
    var creatinine : Int!
    var sgot : Int!
    var sgpt : Int!
    var cgt : Int!
    var alk_phosphatase : Int!
    var total_bilirubin : Int!
    var IRB_notified : Int!
    
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        super.init()
    }
    
    func mapping(map: Map) {
        glucose <- map["glucose"]
        total_protein <- map["total_protein"]
        albumin <- map["albumin"]
        bun <- map["bun"]
        creatinine <- map["creatinine"]
        sgot <- map["sgot"]
        sgpt <- map["sgpt"]
        cgt <- map["cgt"]
        alk_phosphatase <- map["alk_phosphatase"]
        total_bilirubin <- map["total_bilirubin"]
        IRB_notified <- map["IRB_notified"]
    }
    
    func isValid() -> Bool {
        
        if glucose == nil || glucose == 0 ||
            total_protein == nil || total_protein == 0 ||
            albumin == nil || albumin == 0 ||
            bun == nil || bun == 0 ||
            creatinine == nil || creatinine == 0 ||
            sgot == nil || sgot == 0 ||
            sgpt == nil || sgpt == 0 ||
            cgt == nil || cgt == 0 ||
            alk_phosphatase == nil || alk_phosphatase == 0 ||
            total_bilirubin == nil || total_bilirubin == 0 ||
            IRB_notified == nil || IRB_notified == 0{
            return false
        }
        
        return true
    }
}


class UrinalysisInfo: NSObject, Mappable {
    
    var Specific_gravity : Int!
    var reaction : Int!
    var albumin : Int!
    var glucose : Int!
    var acetone : Int!
    var wbcs_hpf : Int!
    var rbcs_hpf : Int!
    var epithelial_cells : Int!
    
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        super.init()
    }
    
    func mapping(map: Map) {
        Specific_gravity <- map["Specific_gravity"]
        reaction <- map["reaction"]
        albumin <- map["albumin"]
        glucose <- map["glucose"]
        acetone <- map["acetone"]
        wbcs_hpf <- map["wbcs_hpf"]
        rbcs_hpf <- map["rbcs_hpf"]
        epithelial_cells <- map["epithelial_cells"]
    }
    
    func isValid() -> Bool {
        
        if Specific_gravity == nil || Specific_gravity == 0 ||
            reaction == nil || reaction == 0 ||
            albumin == nil || albumin == 0 ||
            glucose == nil || glucose == 0 ||
            acetone == nil || acetone == 0 ||
            wbcs_hpf == nil || wbcs_hpf == 0 ||
            rbcs_hpf == nil || rbcs_hpf == 0 ||
            epithelial_cells == nil || epithelial_cells == 0 {
            return false
        }
        
        return true
    }
}

class AbnormalResults: NSObject, Mappable {
    
    var choice : Int!
    var specification : String!
    
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        super.init()
    }
    
    func mapping(map: Map) {
        choice <- map["choice"]
        specification <- map["specification"]
    }
    
    func isValid() -> Bool {
        
        if choice == nil || choice == 0 {
            return false
        }
        
        if choice == 1 {
            if isEmptyString(string: specification) {
                return false
            }
        }
        
        return true
    }
}

class LaboratoryReportForm3: NSObject, Mappable {
    
    var patient_initials : String!
    var study : String!
    var form_no : Int!
    var center : Int!
    var patient_number : Int!
    var vst_date : String!
    
    var rat_per : Int!
    var date_of_sample : String!
    var time_of_sample : String!
    var hematology = [HematologyInfo]()
    var blood_chemistry = [BloodChemistryInfo]()
    var urinalysis = [UrinalysisInfo]()
    var q30AbnormalResults = [AbnormalResults]()
    var q31PregnancyTest : Int!
    var q32BloodDrawn : Int!
    var q33DateSent : String!
    
    var comments : String!
    var completed_by : String!
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
        rat_per <- map["rat_per"]
        date_of_sample <- map["date_of_sample"]
        time_of_sample <- map["time_of_sample"]
        hematology <- map["hematology"]
        blood_chemistry <- map["blood_chemistry"]
        urinalysis <- map["urinalysis"]
        q30AbnormalResults <- map["q30AbnormalResults"]
        q31PregnancyTest <- map["q31PregnancyTest"]
        q32BloodDrawn <- map["q32BloodDrawn"]
        q33DateSent <- map["q33DateSent"]
        comments <- map["comments"]
        completed_by <- map["completed_by"]
        date_of_inv <- map["date_of_inv"]
    }
    
    func isValid() -> Bool {
        
        if isEmptyString(string: patient_initials) ||
            isEmptyString(string: study) ||
            isEmptyString(string: vst_date) ||
            isEmptyString(string: date_of_sample) ||
            isEmptyString(string: time_of_sample) ||
            isEmptyString(string: q33DateSent) ||
            isEmptyString(string: completed_by) ||
            isEmptyString(string: date_of_inv) ||
            isEmptyString(string: comments) {
            return false
        }
        
        if form_no == nil || form_no == 0 ||
            center == nil || center == 0 ||
            patient_number == nil || patient_number == 0 ||
            rat_per == nil || rat_per == 0 ||
            q31PregnancyTest == nil || q31PregnancyTest == 0 ||
            q32BloodDrawn == nil || q32BloodDrawn == 0 {
            return false
        }
        
        for obj in hematology {
            if obj.isValid() == false {
                return false
            }
        }
        for obj in blood_chemistry {
            if obj.isValid() == false {
                return false
            }
        }
        for obj in urinalysis {
            if obj.isValid() == false {
                return false
            }
        }
        for obj in q30AbnormalResults {
            if obj.isValid() == false {
                return false
            }
        }
        return true
    }
}
