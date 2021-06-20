//
//  PokemonDetailContainerViewModel.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/04/21.
//

import Foundation
import ReactiveSwift
import ReactiveCocoa

final class PokemonDetailContentViewModel: AutoInjectable {
    
    // MARK: Public Properties
    var currentIndex: Int
    
    // MARK: Private Properties
    @Observable
    private var state: PokemonDetailContentState = PokemonDetailContentState()
    private let pokemonDetailUseCase: PokemonDetailUseCase
    
    init(pokemonId: Int, pokemonDetailUseCase: PokemonDetailUseCase) {
        self.currentIndex = pokemonId
        self.pokemonDetailUseCase = pokemonDetailUseCase
    }
}

// MARK: Computed Properties
extension PokemonDetailContentViewModel {
    
    var loadingState: Property<AnyLoadingState> {
        $state
            .map(\.pokemonInfoState)
            .map(AnyLoadingState.init)
            .skipRepeats()
    }
    
    var pokemonInfo: Property<PokemonInfo?> {
        $state
            .map(\.pokemonInfo)
    }
    
    var imageUrl: Property<URL?> {
        $state
            .map(\.imageUrl)
    }
    
    var typeOne: SignalProducer<TypeName, Never> {
        return  $state
            .map(\.pokemonInfo?.types)
            .skipNil()
            .flatMap(.latest) { typesList -> SignalProducer<TypeName?, Never> in
                // TODO: move this to extension
                let type = typesList.filter { $0.slot == 1 }.first?.type.name
                return SignalProducer<TypeName?, Never>(value: type)
            }
            .skipNil()
    }
    
    var typeTwo: SignalProducer<TypeName, Never> {
        return  $state
            .map(\.pokemonInfo?.types)
            .skipNil()
            .flatMap(.latest) { typesList -> SignalProducer<TypeName?, Never> in
                let type = typesList.filter { $0.slot == 2 }.first?.type.name
                return SignalProducer<TypeName?, Never>(value: type)
            }
            .skipNil()
    }
}

// MARK: API
extension PokemonDetailContentViewModel {
    
    func fetchPokemonDetail() {
        
        state.pokemonInfoState = .loading(nextPage: false)
        
        pokemonDetailUseCase.execute(id: currentIndex) { [weak self] result in
            
            guard let self = self else { return }
            
            self.state.pokemonInfoState = .completed(result)
        }
    }
}
