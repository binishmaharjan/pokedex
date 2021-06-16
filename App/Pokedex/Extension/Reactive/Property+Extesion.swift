//
//  Property+Extesion.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/06/06.
//

import Foundation
import ReactiveSwift

extension Property {
    
    func on(_ handler: @escaping (Value) -> Void) -> Property<Value> {
        map { value in
            handler(value)
            return value
        }
    }
}

extension Property where Value: OptionalProtocol {
    
    func optionalMap<R>(_ transform: @escaping (Value.Wrapped) -> R) -> Property<R?> {
        map { value -> R? in
            guard let wrapped = value.optional else {
                return nil
            }
            
            return transform(wrapped)
        }
    }
    
    func skipNil() -> SignalProducer<Value.Wrapped, Never> {
        producer.skipNil()
    }
}
