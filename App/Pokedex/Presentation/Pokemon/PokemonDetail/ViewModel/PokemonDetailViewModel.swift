//
//  PokemonDetailViewModel.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/04/14.
//

import Foundation
import ReactiveSwift

final class PokemonDetailViewModel: AutoInjectable {
    
    // MARK: Private Properties
    @Observable 
    private var state = PokemonDetailViewState()
    
    // MARK: Public Properties
    var currentIndex: Int
    
    var type: Property<Type?> {
        $state
            .map(\.backgroundType)
            .skipRepeats()
    }
    
    init(pokemonId: Int, backgroundType: Type?) {
        self.currentIndex = pokemonId
        self.state.backgroundType = backgroundType
    }
}
