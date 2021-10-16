//
//  PokemonRepository.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/04/01.
//

import Foundation

protocol PokemonRepository: ListRepository {
    @discardableResult
    func fetchPokemonList(requestValue: ClosedRange<Int>, _ handler: @escaping (Result<[PokemonListItem], APIError>) -> Void) -> Cancellable?
    
    @discardableResult
    func fetchMasterPokemonData(id: Int, _ handler: @escaping (Result<MasterPokemonData, APIError>) -> Void) -> Cancellable?
}
