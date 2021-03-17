//
//  File.swift
//  
//
//  Created by hirano masaki on 2020/06/04.
//

import Foundation
import SourceKittenFramework

struct Object {
    
    private let name: String
    private let initializers: [Initializer]
    private let factoryMethods: [FactoryMethod]
    private let isAutoInjectable: Bool
    
    init?(structure: Structure) {
        let objectKinds: [SwiftDeclarationKind] = [.class, .struct, .enum]
        guard let kind = structure.kind, objectKinds.contains(kind), let name = structure.name else {
            return nil
        }
        
        self.name = name
        
        let inheritedtypes: [SourceKitRepresentable] = structure[.inheritedtypes] ?? []
        self.isAutoInjectable = inheritedtypes
            .compactMap { $0 as? [String : SourceKitRepresentable] }
            .map(Structure.init)
            .compactMap { $0.name }
            .contains("AutoInjectable")
        
        self.initializers = structure.substructures.compactMap { Initializer(structure: $0, forType: name) }
        self.factoryMethods = structure.substructures.compactMap { FactoryMethod(structure: $0, forType: name) }        
    }
    
    var autoInjectableInitializer: Initializer? {
        if isAutoInjectable, let initializer = initializers.first {
            return initializer
        } else {
            return nil
        }
    }
    
    var autoInjectableFactoryMethod: FactoryMethod? {
        if isAutoInjectable, let factoryMethod = factoryMethods.first {
            return factoryMethod
        } else {
            return nil
        }
    }
}
