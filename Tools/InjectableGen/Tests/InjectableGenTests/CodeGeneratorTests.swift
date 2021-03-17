//
//  File.swift
//  
//
//  Created by hirano masaki on 2020/06/04.
//

import Foundation
import XCTest
import SourceKittenFramework

@testable import InjectableGen

final class CodeGeneratorTests: XCTestCase {
    
    func test_injectable_initializer() throws {
        let initializer = Initializer(
            typeName: "Model",
            parameters: [
                .init(label: "value1", name: "value1", type: "Int"),
                .init(label: "_", name: "value2", type: "String")
            ],
            accessLevel: ""
        )
        
        let generator = CodeGenerator()
        
        let result = generator.generateInjectable(from: initializer)
        let expected = """
        extension Model: FactoryMethodInjectable {

            struct Dependency {
                
                let value1: Int
                let value2: String
                

                init(value1: Int, value2: String) {
                    self.value1 = value1
                    self.value2 = value2
                    
                }
            }
            
            static func makeInstance(dependency: Dependency) -> Model {
                Model(value1: dependency.value1, _: dependency.value2)
            }
        }
        """
        
        XCTAssertEqual(result, expected)
    }
    
    func test_dummy_injectable_initializer() {
        let initializer = Initializer(
            typeName: "Model",
            parameters: [
                .init(label: "value1", name: "value1", type: "Int"),
                .init(label: "_", name: "value2", type: "String")
            ],
            accessLevel: ""
        )
        
        let generator = CodeGenerator()
        
        let result = generator.generateDummyInjectable(from: initializer)
        let expected = """
        struct Model: FactoryMethodInjectable {

            struct Dependency {
                
                let value1: Int
                let value2: String
                
            }
            
            static func makeInstance(dependency: Dependency) -> Model { fatalError() }
        }
        """
        
        XCTAssertEqual(result, expected)
    }
}
