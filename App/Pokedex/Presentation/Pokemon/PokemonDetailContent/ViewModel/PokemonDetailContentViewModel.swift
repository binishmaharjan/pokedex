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
            .map(\.masterPokemonState)
            .map(AnyLoadingState.init)
            .skipRepeats()
    }
    
    var masterPokemonData: Property<MasterPokemonData?> {
        $state
            .map(\.masterPokemonData)
    }
    
    var imageUrl: Property<URL?> {
        $state
            .map(\.imageUrl)
    }
    
    var typeOne: SignalProducer<Type, Never> {
        return  $state
            .map(\.masterPokemonData?.types)
            .skipNil()
            .flatMap(.latest) { pokemonType -> SignalProducer<Type?, Never> in
                // TODO: move this to extension
                let type = pokemonType.filter { $0.slot == 1 }.first?.type.name
                return SignalProducer<Type?, Never>(value: type)
            }
            .skipNil()
    }
    
    var typeTwo: SignalProducer<Type, Never> {
        return  $state
            .map(\.masterPokemonData?.types)
            .skipNil()
            .flatMap(.latest) { pokemonType -> SignalProducer<Type?, Never> in
                let type = pokemonType.filter { $0.slot == 2 }.first?.type.name
                return SignalProducer<Type?, Never>(value: type)
            }
            .skipNil()
    }
    
    var flavoredTextEntry: SignalProducer<String, Never> {
        return $state
            .map(\.masterPokemonData?.flavorTextEntries)
            .skipNil()
            .flatMap(.latest) { entry -> SignalProducer<String?, Never> in
                let description = entry.first?.flavorText.trimNewLine
                return SignalProducer<String?, Never>(value: description)
            }
            .skipNil()
    }
}

// MARK: API
extension PokemonDetailContentViewModel {
    
    func fetchPokemonDetail() {
        
        state.masterPokemonState = .loading(nextPage: false)
        
        pokemonDetailUseCase.execute(id: currentIndex) { [weak self] result in
            
            guard let self = self else { return }
            
            self.state.masterPokemonState = .completed(result)
        }
    }
}
