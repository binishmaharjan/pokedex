//
//  PokemonListUseCase.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/04/01.
//

import Foundation

final class PokemonListUseCase: AutoInjectable {
    
    struct RequestValue {
        let offset: Int
        let limit: Int
    }
    
    private let pokemonRepository: PokemonRepository
    
    init(pokemonRepository: PokemonRepository) {
        self.pokemonRepository = pokemonRepository
    }
    
    func execute(requestValue: RequestValue, _ handler: @escaping(Result<PokemonList, APIError>) -> Void) -> Cancellable? {
        return pokemonRepository.fetchPokemonList(offset: requestValue.offset, limit: requestValue.limit, handler)
    }
}
