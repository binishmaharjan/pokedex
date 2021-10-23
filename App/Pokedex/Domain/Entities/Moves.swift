//
//  Moves.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/07/23.
//

import Foundation

struct Moves {
    struct FlavorTextEntry {
        let text: String
    }
    
    let name: String
    let id: Int
    let type: ElementInfo
    let flavorTextEntries: [FlavorTextEntry]
}

extension Moves {
    
    var description: String {
        flavorTextEntries.first?.text ?? ""
    }
}
