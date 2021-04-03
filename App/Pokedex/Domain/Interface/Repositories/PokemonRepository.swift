//
//  PokemonRepository.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/04/01.
//

import Foundation

protocol PokemonRepository {
    @discardableResult
    func fetchPokemonList(offset: Int, limit: Int, _ handler: @escaping(Result<PokemonList, APIError>) -> Void) -> Cancellable?
}