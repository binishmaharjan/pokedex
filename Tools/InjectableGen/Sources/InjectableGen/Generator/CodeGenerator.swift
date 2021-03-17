//
//  File.swift
//  
//
//  Created by hirano masaki on 2020/06/04.
//

import Foundation
import Stencil
import SourceKittenFramework

struct CodeGenerator {
    
    private let environment = Environment()
}

// MARK: - DummyInjectable

extension CodeGenerator {
    
    func generateDummyInjectable(from injectableImpls: [InjectableImpl]) -> String {
        injectableImpls
            .map(generateDummyInjectable)
            .joined(separator: .lineBreak + .lineBreak)
    }
    
    func generateDummyInjectable(from injectableImpl: InjectableImpl) -> String {
        switch injectableImpl {
        case .injectable(let initializer):
            return generateDummyInjectable(from: initializer)
        case .factoryMethodInjectable(let factoryMethod):
            return generateDummyInjectable(from: factoryMethod)
        }
    }
    
    func generateDummyInjectable(from initializer: Initializer) -> String {
        let parameters = initializer.parameters
        let context: [String : Any] = [
            "typeName" : initializer.typeName,
            "dependencyProperties": parameters.map { "let \($0.name): \($0.type)" },
            "accessLevel" : initializer.accessLevel
        ]
        
        let template = """
        {{ accessLevel }}struct {{ typeName }}: FactoryMethodInjectable {

            {{ accessLevel }}struct Dependency {
                
                {% for property in dependencyProperties %}{{ accessLevel }}{{ property }}
                {% endfor %}
            }
            
            static {{ accessLevel }}func makeInstance(dependency: Dependency) -> {{ typeName }} { fatalError() }
        }
        """
        
        return try! environment.renderTemplate(string: template, context: context)
    }
    
    func generateDummyInjectable(from factoryMethod: FactoryMethod) -> String {
        let parameters = factoryMethod.parameters
        let context: [String : Any] = [
            "typeName" : factoryMethod.typeName,
            "dependencyProperties": parameters.map { "let \($0.name): \($0.type)" },
            "accessLevel" : factoryMethod.accessLevel
        ]
        
        let template = """
        {{ accessLevel }}struct {{ typeName }}: FactoryMethodInjectable {

            {{ accessLevel }}struct Dependency {
                
                {% for property in dependencyProperties %}{{ accessLevel }}{{ property }}
                {% endfor %}
            }
            
            static {{ accessLevel }}func makeInstance(dependency: Dependency) -> {{ typeName }} { fatalError() }
        }
        """
        
        return try! environment.renderTemplate(string: template, context: context)
    }
}

// MARK: - Injectable

extension CodeGenerator {
    
    func generateInjectable(from injectableImpls: [InjectableImpl]) -> String {
        injectableImpls
            .map(generateInjectable)
            .joined(separator: .lineBreak + .lineBreak)
    }
    
    func generateInjectable(from injectableImpl: InjectableImpl) -> String {
        switch injectableImpl {
        case .injectable(let initializer):
            return generateInjectable(from: initializer)
        case .factoryMethodInjectable(let factoryMethod):
            return generateInjectable(from: factoryMethod)
        }
    }
    
    func generateInjectable(from initializer: Initializer) -> String {
        let parameters = initializer.parameters
        let context: [String : Any] = [
            "typeName" : initializer.typeName,
            "parameters": parameters.map(\.description).joined(separator: ", "),
            "initArgs": parameters.map { "\($0.label): dependency.\($0.name)" }.joined(separator: ", "),
            "dependencyProperties": parameters.map { "let \($0.name): \($0.type)" },
            "accessLevel" : initializer.accessLevel,
            "dependencyPropertieNames": parameters.map(\.name),
            "dependencyInitArgs": parameters.map { "\($0.name): \($0.type)" }.joined(separator: ", ")
        ]
        
        let template = """
        extension {{ typeName }}: FactoryMethodInjectable {

            {{ accessLevel }}struct Dependency {
                
                {% for property in dependencyProperties %}{{ accessLevel }}{{ property }}
                {% endfor %}

                {{ accessLevel }}init({{ dependencyInitArgs }}) {
                    {% for property in dependencyPropertieNames %}self.{{ property }} = {{ property }}
                    {% endfor %}
                }
            }
            
            static {{ accessLevel }}func makeInstance(dependency: Dependency) -> {{ typeName }} {
                {{ typeName }}({{ initArgs }})
            }
        }
        """
        
        return try! environment.renderTemplate(string: template, context: context)
    }
    
    func generateInjectable(from factoryMethod: FactoryMethod) -> String {
        let parameters = factoryMethod.parameters
        let context: [String : Any] = [
            "typeName" : factoryMethod.typeName,
            "parameters": parameters.map(\.description).joined(separator: ", "),
            "initArgs": parameters.map { "\($0.label): dependency.\($0.name)" }.joined(separator: ", "),
            "dependencyProperties": parameters.map { "let \($0.name): \($0.type)" },
            "accessLevel" : factoryMethod.accessLevel
        ]
        
        let template = """
        extension {{ typeName }}: FactoryMethodInjectable {

            {{ accessLevel }}struct Dependency {
                
                {% for property in dependencyProperties %}{{ accessLevel }}{{ property }}
                {% endfor %}
            }
            
            static {{ accessLevel }}func makeInstance(dependency: Dependency) -> {{ typeName }} {
                {{ typeName }}.makeInstance({{ initArgs }})
            }
        }
        """
        
        return try! environment.renderTemplate(string: template, context: context)
    }
}

// MARK: - Imports

extension CodeGenerator {
    
    func generateImports(from imports: [Import]) -> String {
        Set(imports)
            .sorted()
            .map { "import \($0.moduleName)" }
            .joined(separator: .lineBreak)
    }
}
