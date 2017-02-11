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
}
