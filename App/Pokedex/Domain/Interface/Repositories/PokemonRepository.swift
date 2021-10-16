//
//  PokemonRepository.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/04/01.
//

import Foundation

protocol PokemonRepository {
    @discardableResult
    func fetchPokemonList(offset: Int, limit: Int, _ handler: @escaping(Result<[ListItem], APIError>) -> Void) -> Cancellable?
    
    @discardableResult
    func fetchPokemonInfoList(requestValue: ClosedRange<Int>, _ handler: @escaping (Result<[TypePokemonListItem], APIError>) -> Void) -> Cancellable?
    
    @discardableResult
    func fetchMasterPokemonData(id: Int, _ handler: @escaping (Result<MasterPokemonData, APIError>) -> Void) -> Cancellable?
}
