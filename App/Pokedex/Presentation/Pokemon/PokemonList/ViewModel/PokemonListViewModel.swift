//
//  PokemonListViewModel.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/04/02.
//

import Foundation
import ReactiveSwift

final class PokemonListViewModel: AutoInjectable {
    
    @Observable
    private var state = PokemonListState()
    private let pokemonFullListUseCase: PokemonFullListUseCase
    private let pokemonListUseCase: PokemonListUseCase
    
    private let initialOffSet: Int = 0
    private let fetchLimit: Int = 50
    private var currentPage: Int = 0
    private var totalPageCount: Int = 1
    private var hasMorePage: Bool { return currentPage < totalPageCount }
    private var nextPage: Int { hasMorePage ? (currentPage + 1) : currentPage }
    
    var loadingState: Property<AnyLoadingState> {
        $state
            .map(\.pokemonList)
            .map(AnyLoadingState.init)
            .skipRepeats()
    }
    
    var sections: Property<PokemonListSections> {
        $state
            .map(\.sections)
            .skipRepeats()
    }
    
    var searchedPokemonList: Property<[ListItem]> {
        $state
            .map(\.searchedPokemonList)
            .skipRepeats()
    }
    
    init(pokemonListUseCase: PokemonListUseCase, pokemonFullListUseCase: PokemonFullListUseCase) {
        self.pokemonFullListUseCase = pokemonFullListUseCase
        self.pokemonListUseCase = pokemonListUseCase
    }
}

// MARK: API
extension PokemonListViewModel {
    
    func fetchPokemonFullList() {
        state.pokemonList = .loading(nextPage: false)
        currentPage = 0
        totalPageCount = 1
        
        pokemonFullListUseCase.execute { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let list):
                // Calculate total number of page
                self.totalPageCount = list.count % self.fetchLimit == 0 ?
                    (list.count / self.fetchLimit) :
                    (list.count / self.fetchLimit) + 1
                
                // Save full list of pokemon in the state
                self.state.addPokemonFullList(list)
                
                // Get Type info for pokemon in paged manner
                self.fetchPokemonList()
                
            case .failure(let error):
                self.state.pokemonList = .completed(.failure(error))
            }
        }
    }
    
    func fetchPokemonList() {
        let startIndex = (currentPage * fetchLimit) + 1
        let endIndex = (currentPage + 1) * fetchLimit
        let requestValue = PokemonListUseCase.RequestValue(range: startIndex...endIndex)
        
        pokemonListUseCase.execute(requestValue: requestValue) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let pokemonList):
                // increase page count
                self.currentPage += 1

                // update state
                self.state.initialPokemons(pokemonList)
                
            case .failure(let error):
                self.state.pokemonList = .completed(.failure(error))
            }
        }
    }
    
    func fetchNextPokemonList() {
        guard hasMorePage else { return}
        
        state.pokemonList = .loading(nextPage: true)
        
        let startIndex = (currentPage * fetchLimit) + 1
        let endIndex = (currentPage + 1) * fetchLimit
        let requestValue = PokemonListUseCase.RequestValue(range: startIndex...endIndex)
        
        pokemonListUseCase.execute(requestValue: requestValue) { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let pokemonList):
                self.currentPage += 1
                
                self.state.appendPokemons(pokemonList)
                
            case .failure(let error):
                self.state.pokemonList = .completed(.failure(error))
            }
        }
    }
}

// MARK: Filter // TODO
extension PokemonListViewModel {
    
    func filter(with text: String) {
        state.searchText = text
    }
}
