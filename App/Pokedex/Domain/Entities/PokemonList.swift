//
//  PokemonList.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/04/01.
//

import Foundation

struct PokemonList {
    let count: Int
    let pokemons: [PokemonListItem]
}

struct PokemonListItem: Equatable {
    let name: String
    let url: String
}
