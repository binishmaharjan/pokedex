//
//  PokemonList.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/04/01.
//

import Foundation

/// For Data Transfer Object

struct PokemonList {
    let count: Int
    let pokemons: [PokemonListItem]
}

struct PokemonListItem: Equatable, SearchResult {
    
    var id: Int {
        guard let lastString = url.split(separator: "/").last, let id = Int(lastString) else {
            return 0
        }
        
        return id
    }

    var name: String
    let url: String
}


/// For Displaying in Cell(Contains Type Information)
struct TypePokemonList: Equatable {
//    let count: Int
    let pokemons: [TypePokemonListItem]
}

struct TypePokemonListItem: Equatable, Comparable {
    
    let name: String
    let id: Int
    let types: [PokemonType]
    
    static func from(pokemonInfo: Pokemon) -> TypePokemonListItem {
        TypePokemonListItem(name: pokemonInfo.name, id: pokemonInfo.id, types: pokemonInfo.types)
    }
    
    static func < (lhs: TypePokemonListItem, rhs: TypePokemonListItem) -> Bool {
        lhs.id < rhs.id
    }
}

