//
//  PokemonSpecies.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/06/20.
//

import Foundation

struct PokemonSpecies {
    
    let id: Int
    let name: String
    
    let captureRate: Int
    let habitat: Habitat
    let generation: Generation
    
    let flavorTextEntries: [FlavorTextEntry]
    let formDescriptions: [FormDescription]
}

struct FlavorTextEntry {
    let flavorText: String

    enum CodingKeys: String, CodingKey {
        case flavorText = "flavor_text"
    }
}

struct FormDescription {
    let description: String
}

struct Habitat {
    let name: String
    
}

struct Generation {
    let name: String
}
