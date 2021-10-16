//
//  MovesListRequest.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/07/24.
//

import Foundation

struct MovesListRequest: APIRequest {
    
    typealias SuccessResponse = ListDTO
    
    private let offset: Int
    private let limit: Int
    
    init(offset: Int, limit: Int) {
        self.offset = offset
        self.limit = limit
    }
    
    var method: HTTP.Method { .get }
    
    var path: String { "move/" }
    
    var queryParameters: [String : Any]? {
        [
            "offset": offset,
            "limit": limit
        ]
    }
}
