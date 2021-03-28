//
//  APIError.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/03/28.
//

import Foundation

struct APIDomainError: Error, Codable, Hashable {
    
    let errorCode: String
    let errorDescription: String
}

enum APIError: Error, Hashable {
    /// Connection Errors
    case httpError(HTTPError)
    /// Server Errors
    case domainError(APIDomainError)
}
