//
//  StringExtensions.swift
//  TestECommerceApp
//
//  Created by Ivan Stebletsov on 05/02/2019.
//  Copyright © 2019 Ivan Stebletsov. All rights reserved.
//

import Foundation

extension String {
    
    func isConformNameConditions() -> Bool {
        guard !self.isEmpty else { return false } // Not empty
        guard self.count >= 2 else { return false } // Count of characters greater than three
        guard self == self.correctTheInputText() else { return false } // Looks neat :)
        return true
    }
    
    func isNumber() -> Bool {
        guard !self.isEmpty else { return false } // Not empty
        guard let _ = Double(self) else { return false } // Can be converted to Double
        return true
    }
    
    func correctTheInputText() -> String {
        let stringComponents = self.components(separatedBy: .whitespaces) // Create array of string elements separated by spaces
        return stringComponents.filter { !$0.isEmpty }.joined(separator: " ") // Filter string elements that not empty (not "") and separated by spaces
    }
    
    func correctTheInputNumber() -> String {
        guard self.count > 1 else { return self } // Check that contains at least 2 numbers or return this one numbe
        guard self.first != "0" else { return "0" } // Because contains more than 1 number, check that second number not zero
        return self.trimmingCharacters(in: CharacterSet(charactersIn: "01234567890.").inverted)
    }
    
    var formattedWithSeparator: String {
        guard let numberForFormat = Double(self) else { return self }
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        return formatter.string(from: numberForFormat as NSNumber)!
    }
    
}
