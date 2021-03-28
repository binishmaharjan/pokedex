//
//  AnyLoadingState.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/03/24.
//

import Foundation

enum AnyLoadingState: Hashable {
    
    enum Failure {
        case retry
    }
    
    case initial
    case loadin(nextPage: Bool)
    case success
    case failure(Failure)
    
    init<Success, Failure>(_ loadingState: LoadingState<Success, Failure>) {
        switch loadingState {
        case .initial:
            self = .initial
        case .loading(nextPage: let nextPage):
            self = .loadin(nextPage: nextPage)
        case .completed(.success):
            self = .success
        case .completed(.failure):
            self = .failure(.retry)
        }
    }
}

extension AnyLoadingState {
    
    var isHiddenInitial: Bool {
        self != .initial
    }
    
    var isHiddenLoading: Bool {
        self != .loadin(nextPage: false)
    }
    
    var isHiddenSuccess: Bool {
        self != .success
    }
    
    var isHiddenFailure: Bool {
        switch self {
        case .failure: return true
        default: return false
        }
    }
}

extension AnyLoadingState.Failure {
    
    var title: String {
        switch self {
        case .retry:
            return "Some Error Occured. Please retry"
        }
    }
    
    var actionName: String {
        switch self {
        case .retry:
            return "Retry"
        }
    }
}
