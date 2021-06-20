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
    var pokemonInfoState: LoadingState<PokemonInfo, APIError> = .initial
    
    var pokemonInfo: PokemonInfo? {
        switch pokemonInfoState {
        case .completed(.success(let pokemonInfo)):
            return pokemonInfo
        default:
            return nil
        }
    }
    
    var imageUrl: URL? {
        switch pokemonInfoState {
        case .completed(.success(let pokemonInfo)):
            let id = pokemonInfo.id
            return ApplicationConfiguration.current.spriteUrl(appending: "/pokemon/other/official-artwork/\(id).png")
        default:
            return nil
        }
    }
}
