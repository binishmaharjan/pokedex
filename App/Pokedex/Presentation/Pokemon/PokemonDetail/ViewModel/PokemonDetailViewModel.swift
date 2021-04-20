//
//  PokemonDetailViewModel.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/04/14.
//

import Foundation

final class PokemonDetailViewModel: AutoInjectable {
    
    // MARK: Private Properties
    @Observable
    private var state = PokemonDetailViewState()
    
    // MARK: Public Properties
    var currentIndex: Int
    
    init(pokemonId: Int) {
        self.currentIndex = pokemonId
    }
}
