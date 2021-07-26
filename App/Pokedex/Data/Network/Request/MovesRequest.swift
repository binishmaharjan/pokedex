//
//  MovesRequest.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/07/24.
//

import Foundation

struct MovesRequest: APIRequest {
    
        typealias SuccessResponse = MovesDTO
    
    private let id: Int
    
    init(id: Int) {
        self.id = id
    }
    
    var method: HTTP.Method { .get }
    
    var path: String { "move/\(id)" }
}
