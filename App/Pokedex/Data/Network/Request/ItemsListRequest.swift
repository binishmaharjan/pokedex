//
//  ItemsListRequest.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/09/14.
//

import Foundation

struct ItemsListRequest: APIRequest {
    
    typealias SuccessResponse = ItemsListDTO
    
    private let offset: Int
    private let limit: Int
    
    init(offset: Int, limit: Int) {
        self.offset = offset
        self.limit = limit
    }
    
    var method: HTTP.Method { .get }
    
    var path: String { "item/" }
    
    var queryParameters: [String : Any]? {
        [
            "offset": offset,
            "limit": limit
        ]
    }
}
