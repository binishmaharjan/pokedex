//
//  PokemonDetailUseCase.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/06/07.
//

import Foundation

final class PokemonDetailUseCase: AutoInjectable {
    
    private let pokemonRepository: PokemonRepository
    
    init(pokemonRepository: PokemonRepository) {
        self.pokemonRepository = pokemonRepository
    }
    
    @discardableResult
    func execute(id:Int, _ handler: @escaping(Result<Pokemon, APIError>) -> Void) -> Cancellable? {
        
        return pokemonRepository.fetchPokemon(id: id, handler)
    }
}
