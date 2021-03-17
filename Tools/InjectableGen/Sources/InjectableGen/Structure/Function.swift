//
//  File.swift
//  
//
//  Created by hirano masaki on 2020/06/04.
//

import Foundation
import SourceKittenFramework

struct Function: Equatable {
    
    struct Parameter: Equatable {
        
        let label: String
        let name: String
        let type: String

        init(label: String, name: String, type: String) {
            self.label = label
            self.name = name
            self.type = type
        }
        
        init?(label: String, structure: Structure) {
            guard structure.isKind(.varParameter), let name = structure.name, let typeName = structure.typeName else {
                return nil
            }
            
            self = .init(label: label, name: name, type: typeName)
        }
        
        var description: String {
            if label == name {
                return "\(name): \(type)"
            } else {
                return "\(label) \(name): \(type)"
            }
        }
    }
    
    let name: String
    let returnType: String?
    let parameters: [Parameter]
    let isStatic: Bool
    let accessLevel: String?
}


extension Function {
    
    init?(structure: Structure) {
        let isInstanceMethod = structure.isKind(.functionMethodInstance)
        let isStaticMethod = structure.isKind(.functionMethodStatic)
        let isTopLevelFunction = structure.isKind(.functionFree)
        
        guard let name = structure.name, isInstanceMethod || isStaticMethod || isTopLevelFunction else {
            return nil
        }
        
        let functionLabels = name.functionLabels()
        self.parameters = zip(functionLabels, structure.substructures).compactMap { label, structure in
            Parameter(label: label, structure: structure)
        }
        self.returnType = structure[.typeName]
        self.name = name
        self.isStatic = isStaticMethod
        self.accessLevel = structure.accessLevel
    }
    
    var isInitializer: Bool {
        name.starts(with: "init(")
    }
    
    var isFactoryMethod: Bool {
        isStatic && name.starts(with: "makeInstance(") 
    }
    
    var accessLevelString: String {
        if let accessLevel = accessLevel {
            return accessLevel + " "
        } else {
            return ""
        }
    }
    
    // ex: init(value1: Int, value2 value2: Int, _ value3: Int) → ["value1", "value2", "_"]
    static func labels(for functionName: String) -> [String] {
        functionName.functionLabels()
    }
}

private extension String {
    
    func functionLabels() -> [String] {
        String(drop { $0 != "(" }).removing("(", ")").components(separatedBy: ":")
    }
    
    func removing(_ string: String) -> String {
        replacingOccurrences(of: string, with: "")
    }
    
    func removing(_ strings: String...) -> String {
        strings.reduce(self) { $0.removing($1) }
    }
}

private extension Structure {
    
    var accessLevel: String? {
        guard let value = dictionary["key.accessibility"] as? String else {
            return nil
        }
        
        let accessLevel = value.replacingOccurrences(of: "source.lang.swift.accessibility.", with: "")
        
        guard accessLevel != "internal" else {
            return nil
        }
        
        return accessLevel
    }
}
