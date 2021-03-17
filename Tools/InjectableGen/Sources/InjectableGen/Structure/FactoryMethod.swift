//
//  File.swift
//  
//
//  Created by hirano masaki on 2020/06/05.
//

import Foundation
import SourceKittenFramework

struct FactoryMethod: Equatable {
    
    let typeName: String
    let parameters: [Function.Parameter]
    let accessLevel: String

    init(typeName: String, parameters: [Function.Parameter], accessLevel: String) {
        self.typeName = typeName
        self.parameters = parameters
        self.accessLevel = accessLevel
    }
    
    init?(structure: Structure, forType typeName: String) {
        guard let function = Function(structure: structure), function.returnType == typeName, function.isFactoryMethod else {
            return nil
        }
        
        self.typeName = typeName
        self.parameters = function.parameters
        self.accessLevel = function.accessLevelString
    }
}
