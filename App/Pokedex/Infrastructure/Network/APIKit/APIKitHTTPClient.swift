//
//  APIKitHTTPClient.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/03/28.
//

import Foundation
import APIKit

final class APIKitHTTPClient: HTTPClient, AutoInjectable {
    
    private let session: Session
    private let apiLogger: APILogger
    
    init(session: Session, apiLogger: APILogger) {
        self.session = session
        self.apiLogger = apiLogger
    }
    
    @discardableResult
    func send<Request>(_ request: Request, _ handler: @escaping (Result<Request.Response, HTTPError>) -> Void) -> Cancellable where Request: HTTPRequest {
        let adaptorRequest = APIKitAdaptor.Request(httpRequest: request, apiLogger: apiLogger)
        let sessionTask = session.send(adaptorRequest) { [weak self] result in
            handler(.init(from: result))
            switch result {
            case .failure(.responseError(let error as DecodingError)):
                 self?.apiLogger.logDecodingError(error, for: request)
            default:
                break
            }
        }
        
        return AnyCancellable {
            sessionTask?.cancel()
        }
    }
}

private extension Result where Failure == HTTPError {
    
    init(from result: Result<Success, SessionTaskError>) {
        switch result {
        case .success(let success):
            self = .success(success)
        case .failure(.connectionError), .failure(.requestError):
            self = .failure(.connectionError)
        case .failure(.responseError):
            self = .failure(.invalidResponseError)
        }
    }
}
