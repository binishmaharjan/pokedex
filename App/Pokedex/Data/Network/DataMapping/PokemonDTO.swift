//
//  PokemonInfoDTO.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/04/03.
//

import Foundation

struct PokemonDTO: Codable {
    let name: String
    let id: Int
    let types: [PokemonTypeDTO]
    let stats: [StatsDTO]
    
    func toDomain() -> Pokemon {
        Pokemon(name: name, id: id, types: types.map { $0.toDomain() }, stats: stats.map { $0.toDomain() })
    }
}

struct PokemonTypeDTO: Codable {
    let slot: Int
    let type: TypeInfoDTO
    
    func toDomain() -> PokemonType {
        PokemonType(slot: slot, type: type.toDomain())
    }
}

struct TypeInfoDTO: Codable {
    let name: Type
    let url: String
    
    func toDomain() -> TypeInfo {
        TypeInfo(name: name, url: url)
    }
}

