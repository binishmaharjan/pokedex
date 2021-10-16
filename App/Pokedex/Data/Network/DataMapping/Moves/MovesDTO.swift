//
//  MovesDTO.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/07/23.
//

import Foundation

struct MovesDTO: Codable {
    
    struct FlavorTextEntryDTO: Codable {
        let text: String
        
        enum CodingKeys: String, CodingKey {
            case text = "flavor_text"
        }
    }
    
    let name: String
    let id: Int
    let type: TypeInfoDTO
    let flavorTextEntries: [FlavorTextEntryDTO]
    
    enum CodingKeys: String, CodingKey {
        case name
        case id
        case type
        case flavorTextEntries = "flavor_text_entries"
    }
    
    func toDomain() -> Moves {
        Moves(name: name, id: id, type: type.toDomain(), flavorTextEntries: flavorTextEntries.map { $0.toDomain() })
    }
}

extension MovesDTO.FlavorTextEntryDTO {
    
    func toDomain() -> Moves.FlavorTextEntry {
        .init(text: text)
    }
}
