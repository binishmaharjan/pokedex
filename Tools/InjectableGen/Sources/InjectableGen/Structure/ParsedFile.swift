//
//  File.swift
//  
//
//  Created by hirano masaki on 2020/06/04.
//

import Foundation
import SourceKittenFramework

struct ParsedFile {
    
    let autoInjectableInitializers: [Initializer]
    let autoInjectableFactoryMethods: [FactoryMethod]
    let imports: [Import]

    init?(file: File) throws {
        let structure = try Structure(file: file)
        let objects = structure.objects()
        
        let autoInjectableInitializers = objects.compactMap(\.autoInjectableInitializer)
        let autoInjectableFactoryMethods = objects.compactMap(\.autoInjectableFactoryMethod)
        
        guard !autoInjectableInitializers.isEmpty || !autoInjectableFactoryMethods.isEmpty else {
            return nil
        }
        
        self.autoInjectableInitializers = autoInjectableInitializers
        self.autoInjectableFactoryMethods = autoInjectableFactoryMethods
        self.imports = try Import.imports(from: file)
    }
    
    static func parsedFiles(from files: [File]) throws -> [ParsedFile] {
        try files.compactMap {
            try ParsedFile(file: $0)
        }
    }
}
