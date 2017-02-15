//
//  String+RUI.swift
//  Juicer
//
//  Created by Srikanth KV on 24/04/15.
//  Copyright (c) 2015 Digital Juice. All rights reserved.
//

import UIKit

extension String {
    
    public func length() -> Int{
        return self.lengthOfBytes(using: String.Encoding.utf8)
    }
    
    func toInt() -> Int? {
        if self.isEmpty {
            return nil
        }
        
        return Int(self)
    }
    
    func canStringBeNumber() -> Bool {
        let numbers = CharacterSet(charactersIn: "0123456789").inverted
        let range = self.rangeOfCharacter(from: numbers)
        
        if range == nil {
            return true
        }
        return false
    }
    
    func canStringBeDecimalNumber() -> Bool {
        do {
            let regularExpr = try NSRegularExpression(pattern: "^(([1-9]*)|(([1-9]*)\\.([0-9]*)))$", options: NSRegularExpression.Options.caseInsensitive)
            let results = regularExpr.matches(in: self, options: NSRegularExpression.MatchingOptions.init(rawValue: 0), range: NSMakeRange(0, self.length()))
            return results.count != 0
        } catch {
            print(error)
        }
        
        return false
        
    }
    
    //^(([1-9]*)|(([1-9]*)\.([0-9]*)))$
    
    func canStringBePhoneNumber() -> Bool {
        if self.length() > 10 {
            return false
        }
        
        let numbers = CharacterSet(charactersIn: "0123456789").inverted
        let range = self.rangeOfCharacter(from: numbers)
        
        if range == nil {
            return true
        }
        return false
    }
    
    func canStringBeZipcode() -> Bool {
        if self.length() > 5 {
            return false
        }
        let numbers = CharacterSet(charactersIn: "0123456789-").inverted
        let range = self.rangeOfCharacter(from: numbers)
        
        if range == nil {
            return true
        }
        return false
    }

}
