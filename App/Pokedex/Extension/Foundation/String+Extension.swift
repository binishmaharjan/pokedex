//
//  String+Extension.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/06/21.
//

import Foundation

extension String {
    
    var trimNewLine: String {
        return replacingOccurrences(of: "\n", with: "")
    }
    
    var removeFormFeedCharacters: String {
        return replacingOccurrences(of: "\u{0C}", with: " ")
    }
}
