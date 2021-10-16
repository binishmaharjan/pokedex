//
//  PokemonListUseCase.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/04/01.
//

import Foundation

final class PokemonTypedListUseCase: AutoInjectable {
    
    struct RequestValue {
        let range: ClosedRange<Int>
    }
    
    private let pokemonRepository: PokemonRepository
    
    init(pokemonRepository: PokemonRepository) {
        self.pokemonRepository = pokemonRepository
    }
    
    @discardableResult
    func execute(requestValue: RequestValue, _ handler: @escaping(Result<[PokemonListItem], APIError>) -> Void) -> Cancellable? {
        
        return pokemonRepository.fetchPokemonInfoList(requestValue: requestValue.range, handler)
    }
}
