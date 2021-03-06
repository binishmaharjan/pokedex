//
//  File.swift
//  
//
//  Created by hirano masaki on 2020/06/04.
//

import Foundation
import SourceKittenFramework

extension Structure {
    
    subscript<T: SourceKitRepresentable>(key: SwiftDocKey) -> T? {
        get {
            return dictionary[key.rawValue] as? T
        }
        set {
            var dictionary = self.dictionary
            dictionary[key.rawValue] = newValue
            self = Structure(sourceKitResponse: dictionary)
        }
    }

    var name: String? {
        return self[.name]
    }

    var kind: SwiftDeclarationKind? {
        return (self[.kind] as String?).flatMap(SwiftDeclarationKind.init)
    }

    func isKind(_ kind: SwiftDeclarationKind) -> Bool {
        self.kind == kind
    }
    
    var typeName: String? {
        return self[.typeName]
    }

    var substructures: [Structure] {
        guard let dictionaries = self[.substructure] as [[String: SourceKitRepresentable]]? else {
            return []
        }

        return dictionaries.map(Structure.init(sourceKitResponse:))
    }

    var elements: [Structure] {
        guard let dictionaries = self.dictionary["key.elements"] as? [[String: SourceKitRepresentable]] else {
            return []
        }

        return dictionaries.map(Structure.init(sourceKitResponse:))
    }

    var offset: Int64? {
        return self[.offset]
    }
    
    var length: Int64? {
        return self[.length]
    }
}

extension Structure {
    
    func objects() -> [Object] {
        substructures.compactMap(Object.init)
    }
}
