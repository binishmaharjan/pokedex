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
    let results: [ListItem]
}

/// Common List Model Received From API
struct ListItem: Equatable, Searchable, ListIdentifiable {
    
    var name: String
    let url: String
}

// MARK: Pokemon List (Pokemon List Including Types)

/// Pokemon List Including Both Primary And Secondary Types That Is Used To Display In List View Controller
struct PokemonListItem: Equatable {
    
    let id: Int
    let name: String
    let elements: [Element]
}

extension PokemonListItem {
    
    static func from(_ pokemonInfo: Pokemon) -> PokemonListItem {
        PokemonListItem(id: pokemonInfo.id,
                        name: pokemonInfo.name,
                        elements: pokemonInfo.types)
    }
}

extension PokemonListItem: Comparable {
    static func < (lhs: PokemonListItem, rhs: PokemonListItem) -> Bool {
        lhs.id < rhs.id
    }
}

// MARK: Moves List (Moves List Including Type)

/// Moves List Including Types That Is Used To Display In List View Controller
struct MovesListItem: Equatable {
    
    let name: String
    let id: Int
    let element: ElementInfo
}

extension MovesListItem {
    
    static func from(_ moveInfo: Moves) -> MovesListItem {
        MovesListItem(name: moveInfo.name, id: moveInfo.id, element: moveInfo.type)
    }
}

extension MovesListItem: Comparable {
    
    static func < (lhs: MovesListItem, rhs: MovesListItem) -> Bool {
        lhs.id < rhs.id
    }
}


// MARK: Items List (Items List Including Price)
