//
//  APILogger.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/03/24.
//

import Foundation

protocol APILogger {
    
    func logRequest(_ urlRequest: URLRequest)
    func logResponse(object: Any, urlResponse: HTTPURLResponse)
    func logDecodingError<Request: HTTPRequest>(_ error: DecodingError, for request: Request)
}

struct DefaultAPILogger: APILogger {
    
    init() { }
    
    func logRequest(_ urlRequest: URLRequest) {
        let log = """
        ---------------------------------------------
                   ▶︎▶︎▶︎🚀 API REQUEST 🚀◀︎◀︎◀︎
        - URL: \(urlRequest.url?.description ?? "nil")
        - HTTPMethod: \(urlRequest.httpMethod ?? "nil")
        - HeaderFields: \(urlRequest.allHTTPHeaderFields?.prettyLog() ?? "[:]")
        - RequestBody: \(JSONSerialization.prettyJSON(of: urlRequest.httpBody))
        ---------------------------------------------
        """
        Logger.debug(log)
    }
    
    func logResponse(object: Any, urlResponse: HTTPURLResponse) {
        let allHeaderFields = urlResponse.allHeaderFields as? [String: String]
        let log = """
        ---------------------------------------------
                   ▶︎▶︎▶︎🎉 API RESPONSE 🎉◀︎◀︎◀︎
        - URL: \(urlResponse.url?.description ?? "nil")
        - HeaderFields: \(allHeaderFields?.prettyLog() ?? "[:]")
        - ResponseBody: \(JSONSerialization.prettyJSON(of: object as? Data))
        ---------------------------------------------
        """
        Logger.debug(log)
    }
    
    func logDecodingError<Request: HTTPRequest>(_ error: DecodingError, for request: Request){
        let log = """
        ---------------------------------------------
                   ▶︎▶︎▶︎💥 PARSE ERROR 💥◀︎◀︎◀︎
        - URL: \(request.baseURL.appendingPathComponent(request.path))
        \(error)
        ---------------------------------------------
        """
        Logger.debug(log)
    }
}

private extension Dictionary where Key == String, Value == String {
    
    func prettyLog() -> String {
        let lines = keys.sorted().map { key in
            """
                "\(key)": "\(self[key]!)"
            """
        }
        
        return """
        [
        \(lines.joined(separator: "\n"))
        ]
        """
    }
}
