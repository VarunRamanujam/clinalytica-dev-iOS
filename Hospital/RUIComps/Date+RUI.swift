//
//  Date+RUI.swift
//  Hospital
//
//  Created by Shridhar on 2/15/17.
//
//

import Foundation
import UIKit

extension Date {
    
    func getString() -> String {
        let format = DateFormatter()
        format.dateFormat = "MM/dd/yyyy"
        
        return format.string(from: self)
    }
    
    static func getDate(str : String?) -> Date? {
        if isEmptyString(string: str) {
            return nil
        }
        
        let format = DateFormatter()
        format.dateFormat = "MM/dd/yyyy"
        
        return format.date(from: str!)
    }
    
    func getTimeString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: self)
    }
}
