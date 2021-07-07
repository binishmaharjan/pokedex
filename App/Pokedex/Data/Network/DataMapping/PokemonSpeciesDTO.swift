//
//  PokemonSpeciesDTO.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/06/20.
//

import Foundation

struct PokemonSpeciesDTO: Codable {
    
    let id: Int
    let name: String
    
    let captureRate: Int
    let habitat: HabitatDTO
    let generation: GenerationDTO
    
    let flavorTextEntries: [FlavorTextEntryDTO]
    let formDescriptions: [FormDescriptionDTO]
    
    enum CodingKeys: String, CodingKey {
        case flavorTextEntries = "flavor_text_entries"
        case formDescriptions = "form_descriptions"
        case captureRate = "capture_rate"
        case habitat
        case generation
        case id
        case name
    }
    
    func toDomain() -> PokemonSpecies {
        PokemonSpecies(id: id,
                       name: name,
                       captureRate: captureRate,
                       habitat: habitat.toDomain(),
                       generation: generation.toDomain(),
                       flavorTextEntries: flavorTextEntries.map { $0.toDomain() },
                       formDescriptions: formDescriptions.map { $0.toDomain() })
    }
}

struct FlavorTextEntryDTO: Codable {
    let flavorText: String
    
    enum CodingKeys: String, CodingKey {
        case flavorText = "flavor_text"
    }
    
    func toDomain() -> FlavorTextEntry {
        FlavorTextEntry(flavorText: flavorText)
    }
}

struct FormDescriptionDTO: Codable {
    let description: String
    
    func toDomain() -> FormDescription {
        FormDescription(description: description)
    }
}

struct HabitatDTO: Codable {
    let name: String
    
    func toDomain() -> Habitat {
        Habitat(name: name)
    }
}

struct GenerationDTO: Codable {
    let name: String
    
    func toDomain() -> Generation {
        Generation(name: name)
    }
}
