//
//  APIClient.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/03/28.
//

import Foundation

protocol APIClient: AnyObject {
    
    @discardableResult
    func send<Request>(_ request: Request, _ handler: @escaping (Result<Request.SuccessResponse, APIError>) -> Void) -> Cancellable where Request: APIRequest
}

final class DefaultAPIClient: APIClient, AutoInjectable {
    
    private let httpClient: HTTPClient
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    func send<Request>(_ request: Request, _ handler: @escaping (Result<Request.SuccessResponse, APIError>) -> Void) -> Cancellable where Request: APIRequest {
        let httpRequest = HTTPRequestAdaptor(baseRequest: request)
        
        let cancellable = httpClient.send(httpRequest) { (response) in
            let result = Result<Request.SuccessResponse, APIError>(from: response)
            
            switch result {
            case .success:
                handler(result)
            case .failure:
                handler(result)
            }
        }
        
        return cancellable
    }
}

extension Result where Failure == APIError {
    
    init(from result: Result<Result<Success, APIDomainError>, HTTPError>) {
        switch result {
        case .success(.success(let successReponse)):
            self = .success(successReponse)
        case .success(.failure(let domainError)):
            self = .failure(.domainError(domainError))
        case .failure(let httpError):
            self = .failure(.httpError(httpError))
        }
    }
}
