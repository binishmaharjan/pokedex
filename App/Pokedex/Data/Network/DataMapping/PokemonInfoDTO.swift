//
//  PokemonInfoDTO.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/04/03.
//

import Foundation

struct PokemonInfoDTO: Codable {
    let name: String
    let id: Int
    let types: [TypesDTO]
    
    func toDomain() -> PokemonInfo {
        PokemonInfo(name: name, id: id, types: types.map { $0.toDomain()} )
    }
}

struct TypesDTO: Codable {
    let slot: Int
    let type: TypeDTO
    
    func toDomain() -> Types {
        Types(slot: slot, type: type.toDomain())
    }
}

struct TypeDTO: Codable {
    let name: TypeName
    let url: String
    
    func toDomain() -> Type {
        Type(name: name, url: url)
    }
}

