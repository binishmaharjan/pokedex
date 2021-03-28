//
//  APIRequest.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/03/27.
//

import Foundation

protocol APIRequest: HTTPRequest where Response == Result<SuccessResponse, APIDomainError> {
    
    associatedtype Response = Result<SuccessResponse, APIDomainError>
    associatedtype SuccessResponse
    
    func parseResult(from data: Data, urlResponse: HTTPURLResponse) throws -> Result<SuccessResponse, APIDomainError>
}

extension APIRequest {
    var baseURL: URL { .baseURL }
    
    func parseResponse(from data: Data, urlResponse: HTTPURLResponse) throws -> Response {
        try parseResult(from: data, urlResponse: urlResponse)
    }
}

extension APIRequest where SuccessResponse: Decodable {
    var contentType: HTTP.MimeType { .applicationJSON }
    
    func parseResponse(from data: Data, urlResponse: HTTPURLResponse) throws -> Response {
        try APIResultParser.default.parseResult(from: data)
    }
}

