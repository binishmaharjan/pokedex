//
//  PokemonDetailViewModel.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/04/14.
//

import Foundation
import ReactiveSwift
import ReactiveCocoa

final class PokemonDetailViewModel: AutoInjectable {
    
    // MARK: Private Properties
    @Observable 
    private var state = PokemonDetailViewState()
    private let pokemonDetailUseCase: PokemonDetailUseCase
    
    // MARK: Public Properties
    var currentIndex: Int
    
    init(pokemonId: Int, backgroundType: Type?,pokemonDetailUseCase: PokemonDetailUseCase) {
        self.currentIndex = pokemonId
        self.pokemonDetailUseCase = pokemonDetailUseCase
        self.state.backgroundType = backgroundType
    }
    
    func changeBackground(to type: Type) {
        state.backgroundType = type
    }
}

// MARK: Computed Properties
extension PokemonDetailViewModel {
    
    var type: Property<Type?> {
        $state
            .map(\.backgroundType)
            .skipRepeats()
    }
    
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
                let description = entry.first?.flavorText
                    .trimNewLine
                    .removeFormFeedCharacters
                
                return SignalProducer<String?, Never>(value: description)
            }
            .skipNil()
    }
}

// MARK: API
extension PokemonDetailViewModel {
    
    func fetchPokemonDetail() {
        
        state.masterPokemonState = .loading(nextPage: false)
        
        pokemonDetailUseCase.execute(id: currentIndex) { [weak self] result in
            
            guard let self = self else { return }
            
            self.state.masterPokemonState = .completed(result)
        }
    }
}
