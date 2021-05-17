//
//  PokemonDetailContainerViewModel.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/04/21.
//

import Foundation

final class PokemonDetailContentViewModel: AutoInjectable {
    
    // MARK: Public Properties
    var currentIndex: Int
    
    init(pokemonId: Int) {
        self.currentIndex = pokemonId
    }
}
