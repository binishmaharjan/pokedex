//
//  LoadingState.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/03/24.
//

import Foundation
import ReactiveSwift
import ReactiveCocoa

enum LoadingState<Success, Failure: Error> {
    case initial
    case loading(nextPage: Bool)
    case completed(Result<Success, Failure>)
    
    static func success(_ success: Success) -> LoadingState<Success, Failure> {
        .completed(.success(success))
    }
    
    static func failure(_ failure: Failure) -> LoadingState<Success, Failure> {
        .completed(.failure(failure))
    }
}

extension LoadingState: Equatable where Success: Equatable, Failure: Equatable {}
extension LoadingState: Hashable where Success: Hashable, Failure: Hashable {}

extension LoadingState {
    
    var isInitial: Bool {
        switch self {
        case .initial: return true
        default: return false
        }
    }
    
    var isLoading: Bool {
        switch self {
        case .loading: return true
        default: return false
        }
    }
    
    var isCompleted: Bool {
        switch self {
        case .completed: return true
        default: return false
        }
    }
    
    var isSuccess: Bool {
        switch self {
        case .completed(.success): return true
        default: return false
        }
    }
    
    var isFailure: Bool {
        switch self {
        case .completed(.failure): return true
        default: return false
        }
    }
}

extension LoadingState {
    
    var successValue: Success? {
        switch self {
        case .completed(.success(let success)):
            return success
        default:
            return nil
        }
    }
    
    var failureValue: Failure? {
        switch self {
        case .completed(.failure(let failure)):
            return failure
        default:
            return nil
        }
    }
}
