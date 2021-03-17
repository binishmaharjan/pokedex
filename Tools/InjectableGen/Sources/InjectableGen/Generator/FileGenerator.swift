//
//  File.swift
//  
//
//  Created by hirano masaki on 2020/06/05.
//

import Foundation
import SourceKittenFramework

struct FileGenerator {
    
    private let context: Context
    private let codeGenerator = CodeGenerator()
    private let importsCodeCache: String
    
    init(context: Context) {
        self.context = context
        self.importsCodeCache = codeGenerator.generateImports(from: context.imports)
    }
    
    func generateInjectableFile() throws -> File {
        let contents = """
        \(importsCodeCache)
        
        \(codeGenerator.generateInjectable(from: context.injectableImpl))
        """
        
        return try File(contents: contents).formatted()
    }
    
    func generateDummyInjectableFile() throws -> File {
        let contents = """
        \(importsCodeCache)
        
        \(codeGenerator.generateDummyInjectable(from: context.injectableImpl))
        """
        
        return try File(contents: contents).formatted()
    }
}

private extension File {
    
    func formatted() throws -> File {
        File(contents: try format(trimmingTrailingWhitespace: true, useTabs: true, indentWidth: 4))
    }
}
