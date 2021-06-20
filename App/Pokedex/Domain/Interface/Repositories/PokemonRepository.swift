//
//  PokemonRepository.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/04/01.
//

import Foundation

protocol PokemonRepository {
    @discardableResult
    func fetchPokemonList(offset: Int, limit: Int, _ handler: @escaping(Result<[PokemonListItem], APIError>) -> Void) -> Cancellable?
    
    @discardableResult
    func fetchPokemon(id: Int, _ handler: @escaping (Result<PokemonInfo, APIError>) ->Void) -> Cancellable?
    
    @discardableResult
    func fetchPokemonInfoList(requestValue: ClosedRange<Int>, _ handler: @escaping (Result<[TypePokemonListItem], APIError>) -> Void) -> Cancellable?
}
