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

struct PokemonListItem: Equatable {
    let name: String
    let url: String
}


/// For Displaying in Cell(Contains Type Information)
struct PokemonTypedList: Equatable {
    let count: Int
    let pokemons: [PokemonTypedListItem]
}

struct PokemonTypedListItem: Equatable, Comparable {
    
    let name: String
    let id: Int
    let types: [Types]
    
    static func from(pokemonInfo: PokemonInfo) -> PokemonTypedListItem {
        PokemonTypedListItem(name: pokemonInfo.name, id: pokemonInfo.id, types: pokemonInfo.types)
    }
    
    static func < (lhs: PokemonTypedListItem, rhs: PokemonTypedListItem) -> Bool {
        lhs.id < rhs.id
    }
}

