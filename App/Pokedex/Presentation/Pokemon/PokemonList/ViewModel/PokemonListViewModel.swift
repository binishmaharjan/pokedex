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
        
        let requestValue = PokemonListUseCase.RequestValue(offset: 0, limit: 50)
        pokemonListUseCase.execute(requestValue: requestValue) { [weak self] (result) in
            switch result {
            case .success(let pokemonList):
                self?.state.pokemonList = .completed(.success(pokemonList.pokemons))
            case .failure(let error):
                self?.state.pokemonList = .completed(.failure(error))
            }
        }
    }
}
