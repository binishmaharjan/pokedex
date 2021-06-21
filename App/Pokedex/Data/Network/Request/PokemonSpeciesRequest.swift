//
//  PokemonSpeciesRequest.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/06/20.
//

import Foundation

//struct PokemonRequest: APIRequest {
//
//    typealias SuccessResponse = PokemonDTO
//
//    private let id: Int
//
//    init(id: Int) {
//        self.id = id
//    }
//
//    var method: HTTP.Method { .get }
//
//    var path: String { "pokemon/\(id)"}
//}

struct PokemonSpeciesRequest: APIRequest {
    
    typealias SuccessResponse = PokemonSpeciesDTO
    
    private let id: Int
    
    init(id: Int) {
        self.id = id
    }
    
    var method: HTTP.Method { .get }
    
    var path: String { "pokemon-species/\(id)" }
}
