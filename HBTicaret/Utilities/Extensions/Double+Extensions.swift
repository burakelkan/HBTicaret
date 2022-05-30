//
//  Double+Extensions.swift
//  HBTicaret
//
//  Created by halil ibrahim Elkan on 27.05.2022.
//

import Foundation

extension Double {
    
    var toString: String {
        return String(self)
    }
    
    var toStringWithCurrency: String {
        return self.toString + "TL"
    }
}
