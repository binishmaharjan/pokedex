//
//  PokemonDetailUseCase.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/06/07.
//

import Foundation
import ReactiveSwift
import ReactiveCocoa

struct MasterPokemonData {
    var id: Int
    var name: String
    
    var types: [PokemonType]
    
    var flavorTextEntries: [FlavorTextEntry]
}

final class PokemonDetailUseCase: AutoInjectable {
    
    private let pokemonRepository: PokemonRepository
    
    init(pokemonRepository: PokemonRepository) {
        self.pokemonRepository = pokemonRepository
    }
    
    @discardableResult
    func execute(id:Int, _ handler: @escaping(Result<MasterPokemonData, APIError>) -> Void) -> Cancellable? {
        
        return pokemonRepository.fetchMasterPokemonData(id: id, handler)
    }
}
