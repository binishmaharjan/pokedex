//
//  PokemonInfoRequest.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/04/03.
//

import Foundation

struct PokemonInfoRequest: APIRequest {
    
    typealias SuccessResponse = PokemonInfoDTO
    
    private let id: Int
    
    init(id: Int) {
        self.id = id
    }
    
    var method: HTTP.Method { .get }
    
    var path: String { "pokemon/\(id)"}
}
