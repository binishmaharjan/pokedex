//
//  File.swift
//  
//
//  Created by hirano masaki on 2020/06/04.
//

import Foundation
import SourceKittenFramework

struct Initializer: Equatable {
    
    let typeName: String
    let parameters: [Function.Parameter]
    let accessLevel: String

    init(typeName: String, parameters: [Function.Parameter], accessLevel: String) {
        self.typeName = typeName
        self.parameters = parameters
        self.accessLevel = accessLevel
    }
    
    init?(structure: Structure, forType typeName: String) {
        guard let function = Function(structure: structure), function.isInitializer else {
            return nil
        }
        
        self.typeName = typeName
        self.parameters = function.parameters
        self.accessLevel = function.accessLevelString
    }
}
