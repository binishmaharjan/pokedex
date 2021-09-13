//
//  ItemsRequest.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/09/14.
//

import Foundation

struct ItemsRequest: APIRequest {
    
    typealias SuccessResponse = ItemsDTO
    
    private let id: Int
    
    init(id: Int) {
        self.id = id
    }
    
    var method: HTTP.Method { .get }
    
    var path: String { "item/\(id)"}
}
