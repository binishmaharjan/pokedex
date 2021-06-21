//
//  ApiClient+Reactive.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/06/21.
//

import Foundation
import ReactiveSwift

extension APIClient {
    
    func send<Request>(_ request: Request) -> SignalProducer<Request.SuccessResponse, APIError> where Request: APIRequest {
        SignalProducer { [weak self] observer, lifetime in
            guard let self = self else {
                observer.sendInterrupted()
                return
            }
            
            let cancellable = self.send(request) { result in
                switch result {
                case .success(let value):
                    observer.send(value: value)
                    observer.sendCompleted()
                case .failure(let error):
                    observer.send(error: error)
                }
            }
            
            lifetime.observeEnded {
                cancellable.cancel()
            }
        }
    }
}
