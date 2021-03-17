//
//  File.swift
//  
//
//  Created by hirano masaki on 2020/06/05.
//

import Foundation

struct Context {
    
    let injectableImpl: [InjectableImpl]
    let imports: [Import]
}

extension Context {
    
    init(parsedFiles: [ParsedFile]) {
        let initializers = parsedFiles.flatMap(\.autoInjectableInitializers).map(InjectableImpl.injectable)
        let factoryMethods = parsedFiles.flatMap(\.autoInjectableFactoryMethods).map(InjectableImpl.factoryMethodInjectable)
        self.injectableImpl = (initializers + factoryMethods).sorted()
        self.imports = parsedFiles.flatMap(\.imports) + [.DIKit]
    }
}
