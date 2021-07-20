//
//  PokemonDetailViewModel.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/04/14.
//

import Foundation
import ReactiveSwift
import ReactiveCocoa
import UIKit

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
}

// MARK: Computed Properties
extension PokemonDetailViewModel {
    
    var type: SignalProducer<Type, Never> {
        SignalProducer.merge(
            $state.map(\.backgroundType).skipNil().take(first: 1),
            $state.map(\.masterPokemonData?.primaryType).skipNil()
        )
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
    
    var typeOne: Property<UIImage?> {
        $state
            .map(\.masterPokemonData?.primaryType)
            .map { UIImage.from($0, imageType: .tag) }
    }
    
    var typeTwo: Property<UIImage?> {
        $state
            .map(\.masterPokemonData?.secondaryType)
            .map { UIImage.from($0, imageType: .tag) }
    }
    
    var primaryColor: Property<UIColor?> {
        $state
            .map(\.masterPokemonData?.primaryType)
            .map { UIColor.primaryColor(for: $0) }
    }
    
    var secondaryColor: Property<UIColor?> {
        $state
            .map(\.masterPokemonData?.primaryType)
            .map { UIColor.secondaryColor(for: $0) }
    }
    
    var hideSecondaryType: Property<Bool?> {
        $state
            .map(\.masterPokemonData?.hasOnlyPrimaryType)
    }
    
    var flavoredTextEntry: SignalProducer<String, Never> {
        $state
            .map(\.masterPokemonData?.description)
            .skipNil()
    }
    
    var statsSections: Property<StatsViewSections> {
        $state
            .map(\.statsSections)
            .skipRepeats()
    }
    
    var weaknessSection: Property<WeaknessViewSections> {
        $state
            .map(\.weaknessSection)
            .skipRepeats()
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
