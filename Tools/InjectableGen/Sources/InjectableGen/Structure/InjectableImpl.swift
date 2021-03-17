//
//  File 2.swift
//  
//
//  Created by hirano masaki on 2020/06/05.
//

import Foundation

enum InjectableImpl {
    
    case injectable(Initializer)
    case factoryMethodInjectable(FactoryMethod)
}

extension InjectableImpl: Comparable {
    
    private var typeName: String {
        switch self {
        case .injectable(let initializer):
            return initializer.typeName
        case .factoryMethodInjectable(let factoryMethod):
            return factoryMethod.typeName
        }
    }
    
    static func < (lhs: InjectableImpl, rhs: InjectableImpl) -> Bool {
        lhs.typeName < rhs.typeName
    }
}
