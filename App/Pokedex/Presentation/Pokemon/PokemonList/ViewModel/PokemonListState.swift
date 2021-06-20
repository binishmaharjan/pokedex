//
//  PokemonListState.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/04/02.
//

import Foundation

// Current Problem load finishes but log keeps on printing
// So Dispatch Group Notify is delayed
// Due to current bug?? or something indicator is hidden fast
// but the logs still keeps printing
struct PokemonListState {
    
    // MARK: Private Properties
    private var pokemonFullList: [PokemonListItem] = []
    private var currentPokemonList: [TypePokemonListItem] = [] // Current loaded pokemon with type
    
    // MARK: Paging Related
    private let initialOffSet: Int = 0
    private let fetchLimit: Int = 50
    private var currentPage: Int = 0
    private var totalPageCount: Int = 1
    private var hasMorePage: Bool { return currentPage < totalPageCount }
    private var nextPage: Int { hasMorePage ? (currentPage + 1) : currentPage }
    
    // MARK: Public Properties
    var pokemonList: LoadingState<[TypePokemonListItem], APIError> = .initial
    var searchText: String = ""
    
    var sections: PokemonListSections {
        switch pokemonList {
        case .completed(.success(let list)):
            return .from(list)
        case .loading(nextPage: true):
            return .from(currentPokemonList)
        case .initial, .loading(nextPage: false), .completed(.failure):
            return .empty
        }
    }
    
    var searchedPokemonList: [PokemonListItem] {
        guard !(searchText.isEmpty) else {
            return pokemonFullList
        }
        
        return pokemonFullList.filter { $0.name.contains(searchText) }
    }
    
    mutating func addPokemonFullList(_ list: [PokemonListItem]) {
        pokemonFullList = list
    }
    
    mutating func initialPokemons(_ list: [TypePokemonListItem]) {
        currentPokemonList = list
        pokemonList = .completed(.success(currentPokemonList))
    }
    
    mutating func appendPokemons(_ list: [TypePokemonListItem]) {
        currentPokemonList.append(contentsOf: list)
        pokemonList = .completed(.success(currentPokemonList))
    }
}


// MARK: Sections
typealias PokemonListSections = Sections<String, TypePokemonListItem>

extension PokemonListSections {
    
    static func from(_ pokemons: [TypePokemonListItem]) -> PokemonListSections {
        let sections = PokemonListSections(
            sections: [
                Section(
                    model: "Pokemon",
                    elements: pokemons
                )
            ]
        )
        
        return sections
    }
}
