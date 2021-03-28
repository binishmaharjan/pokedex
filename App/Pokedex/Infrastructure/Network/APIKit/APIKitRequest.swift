//
//  APIKitRequest.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/03/28.
//

import Foundation
import APIKit

extension APIKitAdaptor {
    
    /// HTTPRequestをAPIKit.Requestに変換するリクエスト
    struct Request<BaseRequest: HTTPRequest>: APIKit.Request {
        typealias Response = BaseRequest.Response
        
        private let baseRequest: BaseRequest
        private let apiLogger: APILogger
        
        init(httpRequest: BaseRequest, apiLogger: APILogger) {
            self.baseRequest = httpRequest
            self.apiLogger = apiLogger
        }
        
        var baseURL: URL { baseRequest.baseURL }
        
        var method: HTTPMethod { httpMethod(for: baseRequest.method) }
        
        var path: String { baseRequest.path }
        
        var queryParameters: [String : Any]? { baseRequest.queryParameter }
        
        var bodyParameters: BodyParameters? {
            guard let bodyParameters = baseRequest.bodyParameter else { return nil }
            return APIKitAdaptor.DataBodyParameters(bodyParameters)
        }
        
        var headerFields: [String : String] { baseRequest.headerFields.dictionary }
        
        var dataParser: DataParser { APIKitAdaptor.RawDataParser(contentType: baseRequest.contentType) }
        
        func response(from object: Any, urlResponse: HTTPURLResponse) throws -> BaseRequest.Response {
            guard let data = object as? Data else {
                throw ResponseError.unexpectedObject(object)
            }
            
            return try baseRequest.parseResponse(from: data, urlResponse: urlResponse)
        }
        
        func intercept(urlRequest: URLRequest) throws -> URLRequest {
            apiLogger.logRequest(urlRequest)
            return urlRequest
        }
        
        func intercept(object: Any, urlResponse: HTTPURLResponse) throws -> Any {
            apiLogger.logResponse(object: object, urlResponse: urlResponse)
            return object
        }
    }
}
