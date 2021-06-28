//
//  Type.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/04/03.
//

import Foundation

struct PokemonType: Equatable {
    let slot: Int
    let type: TypeInfo
}

struct TypeInfo: Equatable  {
    let name: Type
    let url: String
}

enum Type: String, Codable, Equatable {
    case normal
    case fighting
    case flying
    case poison
    case ground
    case rock
    case bug
    case ghost
    case steel
    case fire
    case water
    case grass
    case electric
    case psychic
    case ice
    case dragon
    case dark
    case fairy
    case unknown
    case shadow
}
