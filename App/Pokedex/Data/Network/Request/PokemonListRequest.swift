//
//  PokemonListRequest.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/04/02.
//

import Foundation

struct PokemonListRequest: APIRequest {
    
    typealias SuccessResponse = PokemonListDTO
    
    private let offset: Int
    private let limit: Int

    init(offset: Int, limit: Int) {
        self.offset = offset
        self.limit = limit
    }
    
    var method: HTTP.Method { .get }
    
    var path: String { "pokemon/" }
    
    var queryParameters: [String : Any]? {
        [
            "offset": offset,
            "limit": limit
        ]
    }
    
//    var bodyParameters: HTTPBodyParameters? {
//        struct Body: Encodable {
//            let offset: Int
//            let limit: Int
//        }
//
//        let body = Body(offset: offset, limit: limit)
//        return JSONHTTPBodyParameters(body)
//    }
}
