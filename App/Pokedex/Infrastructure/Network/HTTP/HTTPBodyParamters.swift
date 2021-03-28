//
//  HTTPBodyParamter.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/03/24.
//

import Foundation

protocol HTTPBodyParameters {
    
    var contentType: HTTP.MimeType { get }
    func buildEntity() throws -> Data
}

struct JSONHTTPBodyParameters<Entity: Encodable>: HTTPBodyParameters {
    
    private let entity: Entity
    
    init(_ entity: Entity) {
        self.entity = entity
    }
    
    var contentType: HTTP.MimeType {
        .applicationJSON
    }
    
    func buildEntity() throws -> Data {
        let jsonEncoder = JSONEncoder()
        return try jsonEncoder.encode(entity)
    }
}
