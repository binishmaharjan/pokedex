//
//  Int+Extension.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/03/31.
//

import Foundation

extension Int {
    
    var stringId: String {
        let threeDigitId = String(format: "%03d", self)
        return "#\(threeDigitId)"
    }
}
