//
//  ItemsDTO.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/09/14.
//

import Foundation

struct ItemsDTO: Codable {
    
    struct EffectEntryDTO: Codable {
        let effect: String
    }
    
    struct FlavorTextEntryDTO: Codable {
        let text: String
    }
    
    let name: String
    let id: Int
    let cost: Int
    let effectEntries: [EffectEntryDTO]
    let flavorTextEntries: [FlavorTextEntryDTO]
    
    enum CodingKeys: String, CodingKey {
        case name
        case id
        case cost
        case effectEntries = "effect_entries"
        case flavorTextEntries = "flavor_text_entries"
    }
    
    func toDomain() -> Items {
        Items(name: name,
              id: id,
              price: cost,
              effectEntries: effectEntries.map { $0.toDomain() },
              flavorTextEntries: flavorTextEntries.map { $0.toDomain() })
    }
}

extension ItemsDTO.EffectEntryDTO {
    func toDomain() -> Items.EffectEntry {
        .init(effect: effect)
    }
}

extension ItemsDTO.FlavorTextEntryDTO {
    func toDomain() -> Items.FlavorTextEntry {
        .init(text: text)
    }
}
