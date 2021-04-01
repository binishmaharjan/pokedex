//
//  HTTPRequest.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/03/24.
//

import Foundation

protocol HTTPRequest {
    
    associatedtype Response
    
    var baseURL: URL { get }
    
    var method: HTTP.Method { get }
    
    var path: String { get }
    
    var contentType: HTTP.MimeType { get }
    
    var queryParameters: [String: Any]? { get }
    var bodyParameters: HTTPBodyParameters? { get }
    
    var headerFields: HTTPHeaderFields { get }
    
    func parseResponse(from data: Data, urlResponse: HTTPURLResponse) throws -> Response
}

extension HTTPRequest {
    var queryParameters: [String: Any]? { nil }
    var bodyParameters: HTTPBodyParameters? { nil }
    var headerFields: HTTPHeaderFields { .empty }
}

extension HTTPRequest where Response: Decodable {
    
    var contentType: HTTP.MimeType { .applicationJSON }
    
    func parseResponse(from data: Data, urlResponse: HTTPURLResponse) throws -> Response {
        let jsonDecoder = JSONDecoder()
        let response = try jsonDecoder.decode(Response.self, from: data)
        return response
    }
}
