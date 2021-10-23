//
//  MasterPokemonData.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/07/23.
//

import Foundation

struct MasterPokemonData {
    var id: Int
    var name: String
    
    var types: [Element]
    
    var stats: [Stats]
    
    var flavorTextEntries: [FlavorTextEntry]
    
    let captureRate: Int
    let habitat: Habitat
    let generation: Generation
    
    // MARK: Computed Properties
    var primaryType: Type? {
        types.filter { $0.slot == 1 }.first?.type.name
    }
    
    var secondaryType: Type? {
        types.filter { $0.slot == 2 }.first?.type.name
    }
    
    var hasOnlyPrimaryType: Bool {
        secondaryType == nil
    }
    
    var description: String? {
        flavorTextEntries.first?.flavorText
            .trimNewLine
            .removeFormFeedCharacters
    }
}
