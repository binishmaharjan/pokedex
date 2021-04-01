//
//  Observable.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/04/02.
//

import Foundation
import ReactiveSwift

@propertyWrapper
final class Observable<Value>: PropertyProtocol {

    let projectedValue: Property<Value>
    
    private let mutableProperty: MutableProperty<Value>
    
    init(wrappedValue: Value) {
        self.mutableProperty = MutableProperty(wrappedValue)
        self.projectedValue = Property(mutableProperty)
    }
    
    var wrappedValue: Value {
        get { mutableProperty.value }
        set { mutableProperty.value = newValue }
    }
    
    var value: Value {
        wrappedValue
    }

    var signal: Signal<Value, Never> {
        mutableProperty.signal
    }
    
    var producer: SignalProducer<Value, Never> {
        mutableProperty.producer
    }
}
