//
//  Type.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/04/03.
//

import Foundation

struct Types: Equatable {
    let slot: Int
    let type: Type
}

struct Type: Equatable  {
    let name: TypeName
    let url: String
}

enum TypeName: String, Codable {
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
