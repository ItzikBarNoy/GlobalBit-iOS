//
//  DataTypes+Extensions.swift
//  GlobalBit Assignment
//
//  Created by Itzik Bar-Noy on 26/05/2020.
//  Copyright © 2020 Itzik Bar-Noy. All rights reserved.
//

import Foundation

extension String {
    
    func substring(from startIndex: Int, to endIndex: Int) -> String? {
        guard startIndex >= 0 && startIndex < self.count && endIndex >= 0 && endIndex < self.count else { return nil }
        
        let start = self.index(self.startIndex, offsetBy: startIndex)
        let end = self.index(self.startIndex, offsetBy: endIndex)
        
        return String(self[start...end])
    }
}

extension Int {
    
    func getThousandSeparator() -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        
        return formatter.string(from: NSNumber(value: self))
    }
}
