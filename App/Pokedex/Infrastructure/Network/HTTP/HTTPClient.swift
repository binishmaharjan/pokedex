//
//  HTTPClient.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/03/25.
//

import Foundation

protocol HTTPClient: AnyObject {
    
    @discardableResult
    func send<Request>(_ request: Request, _ handler: @escaping (Result<Request.Response, HTTPError>) -> Void) -> Cancellable where Request: HTTPRequest
}
