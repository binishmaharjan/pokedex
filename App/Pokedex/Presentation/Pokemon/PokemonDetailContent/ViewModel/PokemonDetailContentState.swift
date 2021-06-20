//
//  PokemonDetailContentState.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/06/17.
//

import Foundation

struct PokemonDetailContentState {
    
    // MARK: Private Properties
    
    // MARK: Public Properties
    var masterPokemonState: LoadingState<Pokemon, APIError> = .initial
    
    var pokemonInfo: Pokemon? {
        switch masterPokemonState {
        case .completed(.success(let pokemonInfo)):
            return pokemonInfo
        default:
            return nil
        }
    }
    
    var imageUrl: URL? {
        switch masterPokemonState {
        case .completed(.success(let pokemonInfo)):
            let id = pokemonInfo.id
            return ApplicationConfiguration.current.spriteUrl(appending: "/pokemon/other/official-artwork/\(id).png")
        default:
            return nil
        }
    }
}
