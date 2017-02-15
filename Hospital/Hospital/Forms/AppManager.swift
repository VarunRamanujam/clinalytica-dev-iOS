//
//  AppManager.swift
//  Hospital
//
//  Created by Shridhar on 2/13/17.
//
//

import UIKit
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

class AppManager: NSObject {

    func sendRequestToSubmitFormOne(formOneObject : BackgroundInformationForm1, complitionHandle : @escaping (_ response : AppResponse?) -> Void) {
        
        let URL = FormOneUrl
        
        let headers = ["Content-Type" : "application/json"]
        print(formOneObject.toJSONString() ?? "")
        Alamofire.request(URL, method: .post, parameters: formOneObject.toJSON(), encoding: JSONEncoding.default, headers: headers).responseObject { (response : DataResponse<AppResponse>) in
            
            print(NSString(data: response.data!, encoding: String.Encoding.utf8.rawValue) ?? "")
            
            complitionHandle(response.result.value)
        }
    }
    
    func sendRequestToSubmitFormTwo(formTwoObject : MedicalHistoryAndStatusInfo, complitionHandle : @escaping (_ response : AppResponse?) -> Void) {
        
        let URL = FormTwoUrl
        
        let headers = ["Content-Type" : "application/json"]
        print(formTwoObject.toJSONString() ?? "")
        Alamofire.request(URL, method: .post, parameters: formTwoObject.toJSON(), encoding: JSONEncoding.default, headers: headers).responseObject { (response : DataResponse<AppResponse>) in
            
            print(NSString(data: response.data!, encoding: String.Encoding.utf8.rawValue) ?? "")
            
            complitionHandle(response.result.value)
        }
    }
    
    func sendRequestToSubmitFormThree(formThreeObject : LaboratoryReportForm3, complitionHandle : @escaping (_ response : AppResponse?) -> Void) {
        
        let URL = FormThreeUrl
        
        let headers = ["Content-Type" : "application/json"]
        print(formThreeObject.toJSONString() ?? "")
        
        Alamofire.request(URL, method: .post, parameters: formThreeObject.toJSON(), encoding: JSONEncoding.default, headers: headers).responseObject { (response : DataResponse<AppResponse>) in
            
            print(NSString(data: response.data!, encoding: String.Encoding.utf8.rawValue) ?? "")
            
            complitionHandle(response.result.value)
        }
    }
    
    func sendRequestToSubmitFormFour(formFourObject : StudyAdmissionForm4, complitionHandle : @escaping (_ response : AppResponse?) -> Void) {
        
        let URL = FormFourUrl
        
        let headers = ["Content-Type" : "application/json"]
        
        print(formFourObject.toJSONString() ?? "")
        Alamofire.request(URL, method: .post, parameters: formFourObject.toJSON(), encoding: JSONEncoding.default, headers: headers).responseObject { (response : DataResponse<AppResponse>) in
            
            print(NSString(data: response.data!, encoding: String.Encoding.utf8.rawValue) ?? "")
            
            complitionHandle(response.result.value)
        }
    }
    
    func sendRequestToSubmitFormFive(formFourObject : AdverseEventsForm5, complitionHandle : @escaping (_ response : AppResponse?) -> Void) {
        
        let URL = FormFive
        
        let headers = ["Content-Type" : "application/json"]
        
        print(formFourObject.toJSONString() ?? "")
        Alamofire.request(URL, method: .post, parameters: formFourObject.toJSON(), encoding: JSONEncoding.default, headers: headers).responseObject { (response : DataResponse<AppResponse>) in
            
            print(NSString(data: response.data!, encoding: String.Encoding.utf8.rawValue) ?? "")
            
            complitionHandle(response.result.value)
        }
    }
}

class AppResponse: NSObject, Mappable {
    
    var status : String!
    var statusMessage : String!
    
    required init?(map: Map) {
        super.init()
    }
    
    func mapping(map: Map) {
        status <- map["status"]
        statusMessage <- map["statusMessage"]
    }
    
    func isSuccess() -> Bool {
        if status != nil && status.lowercased() == okStatus {
            return true
        }
        
        return false
    }
}
