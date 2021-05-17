//
//  PokemonFullListUseCase.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/04/05.
//

import Foundation

final class PokemonFullListUseCase: AutoInjectable {
    
    struct RequestValue {
        let offset = 0
        let limit = 1118
    }
    
    private let pokemonRepository: PokemonRepository
    
    init(pokemonRepository: PokemonRepository) {
        self.pokemonRepository = pokemonRepository
    }
    
    @discardableResult
    func execute(_ handler: @escaping (Result<[PokemonListItem], APIError>) -> Void) -> Cancellable? {
        let requestValue = RequestValue()
        return pokemonRepository.fetchPokemonList(offset: requestValue.offset, limit: requestValue.limit, handler)
    }
}
