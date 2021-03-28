//
//  HTTPRequestAdaptor.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/03/28.
//

import Foundation

/// WE Creates APIRequest, we convert them to HTTPRequest
///// APIRequest を HTTPRequest として扱うための変換層
struct HTTPRequestAdaptor<BaseRequest: APIRequest>: HTTPRequest {
    
    typealias Response = BaseRequest.Response
    
    private let baseRequest: BaseRequest
    
    init(baseRequest: BaseRequest) {
        self.baseRequest = baseRequest
    }
    
    var baseURL: URL { baseRequest .baseURL }
    var method: HTTP.Method { baseRequest.method }
    var path: String { baseRequest.path }
    var contentType: HTTP.MimeType { baseRequest.contentType }
    var queryParameter: [String : Any]? { baseRequest.queryParameter }
    var bodyParameter: HTTPBodyParameters? { baseRequest.bodyParameter }
    var headerFields: HTTPHeaderFields { baseRequest.headerFields }
    
    func parseResponse(from data: Data, urlResponse: HTTPURLResponse) throws -> Response {
        try baseRequest.parseResult(from: data, urlResponse: urlResponse)
    }
}
