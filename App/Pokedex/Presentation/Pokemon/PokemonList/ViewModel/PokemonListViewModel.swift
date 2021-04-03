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
    
    init(pokemonListUseCase: PokemonListUseCase) {
        self.pokemonListUseCase = pokemonListUseCase
    }
}

// MARK: API
extension PokemonListViewModel {
    
    func fetchPokemonList() {
        state.pokemonList = .loading(nextPage: false)
        currentPage = 0
        totalPageCount = 1
        
        let requestValue = PokemonListUseCase.RequestValue(offset: 0, limit: fetchLimit)
        pokemonListUseCase.execute(requestValue: requestValue) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let pokemonList):
                // increase page count
                self.currentPage += 1
                // calculate total number of page
                self.totalPageCount = pokemonList.count % self.fetchLimit == 0 ?
                    (pokemonList.count / self.fetchLimit) :
                    (pokemonList.count / self.fetchLimit) + 1
                // update state
                self.state.initialPokemons(pokemonList.pokemons)
                
            case .failure(let error):
                self.state.pokemonList = .completed(.failure(error))
            }
        }
    }
    
    func fetchNextPokemonList() {
        state.pokemonList = .loading(nextPage: true)
        let requestValue = PokemonListUseCase.RequestValue(offset: currentPage * fetchLimit, limit: fetchLimit)
        pokemonListUseCase.execute(requestValue: requestValue) { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let pokemonList):
                self.currentPage += 1
                self.totalPageCount = pokemonList.count % self.fetchLimit == 0 ?
                    (pokemonList.count / self.fetchLimit) :
                    (pokemonList.count / self.fetchLimit) + 1
                
                self.state.appendPokemons(pokemonList.pokemons)
            case .failure(let error):
                self.state.pokemonList = .completed(.failure(error))
            }
        }
    }
}
