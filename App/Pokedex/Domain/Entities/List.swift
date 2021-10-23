//
//  List.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/10/16.
//

import Foundation

// MARK: List

/// Common List Model Received From API
struct List {
    
    let count: Int
    let results: [ListObject]
}

/// Common List Model Received From API
struct ListObject: Equatable, Searchable, ListIdentifiable {
    
    var name: String
    let url: String
}

// MARK: Pokemon List (Pokemon List Including Types)

/// Pokemon List Including Both Primary And Secondary Types That Is Used To Display In List View Controller
struct PokemonListObject: Equatable {
    
    let id: Int
    let name: String
    let elements: [Element]
}

extension PokemonListObject {
    
    static func from(_ pokemonInfo: Pokemon) -> PokemonListObject {
        PokemonListObject(id: pokemonInfo.id,
                        name: pokemonInfo.name,
                        elements: pokemonInfo.types)
    }
}

extension PokemonListObject: Comparable {
    static func < (lhs: PokemonListObject, rhs: PokemonListObject) -> Bool {
        lhs.id < rhs.id
    }
}

// MARK: Moves List (Moves List Including Type)

/// Moves List Including Types That Is Used To Display In List View Controller
struct MovesListObject: Equatable {
    
    let name: String
    let id: Int
    let element: ElementInfo
}

extension MovesListObject {
    
    static func from(_ moveInfo: Moves) -> MovesListObject {
        MovesListObject(name: moveInfo.name, id: moveInfo.id, element: moveInfo.type)
    }
}

extension MovesListObject: Comparable {
    
    static func < (lhs: MovesListObject, rhs: MovesListObject) -> Bool {
        lhs.id < rhs.id
    }
}


// MARK: Items List (Items List Including Price)
struct ItemsListObject: Equatable {
    let id: Int
    let name: String
    let price: Int
}

extension ItemsListObject {
    
    static func from(_ itemInfo: Items) -> ItemsListObject {
        ItemsListObject(id: itemInfo.id, name: itemInfo.name, price: itemInfo.price)
    }
}

extension ItemsListObject: Comparable {
    
    static func < (lhs: ItemsListObject, rhs: ItemsListObject) -> Bool {
        lhs.id < rhs.id
    }
}
