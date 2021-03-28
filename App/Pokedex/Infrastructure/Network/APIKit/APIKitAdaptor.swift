//
//  APIKitAdaptor.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/03/28.
//

import Foundation
import APIKit

enum APIKitAdaptor {
    
    static let session: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        return Session(adapter: URLSessionAdapter(configuration: configuration))
    }()
    
    // MARK: - DataParser
    struct RawDataParser: DataParser {
        var contentType: String?
        
        init(contentType: HTTP.MimeType) {
            self.contentType = contentType.rawValue
        }
        
        func parse(data: Data) throws -> Any {
            data
        }
    }
    
    // MARK: - BodyParameters
    struct DataBodyParameters: BodyParameters {
        private let httpBodyParameters: HTTPBodyParameters
        
        init(_ httpBodyParameters: HTTPBodyParameters) {
            self.httpBodyParameters = httpBodyParameters
        }
        
        var contentType: String { self.httpBodyParameters.contentType.rawValue }
        
        func buildEntity() throws -> RequestBodyEntity {
            let data = try httpBodyParameters.buildEntity()
            return .data(data)
        }
    }
    
    static func httpMethod(for method: HTTP.Method) -> HTTPMethod {
        switch method {
        case .get:
            return .get
        case .post:
            return .post
        }
    }
}
