//
//  Cancellabe.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/03/27.
//

import Foundation
import ReactiveSwift

public protocol Cancellable {
    
    func cancel()
}

struct AnyCancellable: Cancellable {
    private let _cancel: () -> Void
    
    init(_ cancel: @escaping () -> Void) {
        self._cancel = cancel
    }
    
    func cancel() {
        _cancel()
    }
}

final class MockCancellable: Cancellable {
    
    private(set) var isCancelled = false
    
    func cancel() {
        isCancelled = true
    }
}

extension AnyDisposable: Cancellable {
    
    public func cancel() {
        dispose()
   
    }
}
