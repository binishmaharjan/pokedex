//
//  PokemonListState.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/04/02.
//

import Foundation

struct PokemonListState {
    
    private var currentPokemonList: [PokemonTypedListItem] = []
    var pokemonList: LoadingState<[PokemonTypedListItem], APIError> = .initial
    var searchText: String = ""
    
    var sections: PokemonListSections {
        switch pokemonList {
        case .completed(.success(let list)):
            return .from(list, filterWith: searchText)
        case .loading(nextPage: true):
            return .from(currentPokemonList, filterWith: searchText)
        case .initial, .loading(nextPage: false), .completed(.failure):
            return .empty
        }
    }
    
    mutating func initialPokemons(_ list: [PokemonTypedListItem]) {
        currentPokemonList = list
        pokemonList = .completed(.success(currentPokemonList))
    }
    
    mutating func appendPokemons(_ list: [PokemonTypedListItem]) {
        currentPokemonList.append(contentsOf: list)
        pokemonList = .completed(.success(currentPokemonList))
    }
}


// MARK: Sections
typealias PokemonListSections = Sections<String, PokemonTypedListItem>

extension PokemonListSections {
    
    static func from(_ pokemons: [PokemonTypedListItem], filterWith: String) -> PokemonListSections {
        let sections = PokemonListSections(
            sections: [
                Section(
                    model: "Pokemon",
                    elements: pokemons
                )
            ]
        )
        
        if filterWith.isEmpty {
            return sections
        } else {
            return sections
                .filter { $0.name.contains(filterWith) }
        }
    }
}
