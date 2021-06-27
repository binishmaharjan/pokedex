//
//  PokemonDetailViewState.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/04/17.
//

import Foundation

struct PokemonDetailViewState {
    var backgroundType: Type?
    var masterPokemonState: LoadingState<MasterPokemonData, APIError> = .initial
    
    var masterPokemonData: MasterPokemonData? {
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
