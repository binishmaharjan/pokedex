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

final class ParsedFileTests: XCTestCase {
    
    func testParseAutoInjectableInitializers() throws {
        let contents = """
        struct Model: AutoInjectable {
            
            init(value: Int) {
                
            }
        }
        """
        
        let file = File(contents: contents)
        let parsedFile = try ParsedFile(file: file)!
        
        let result = parsedFile.autoInjectableInitializers
        let expected = [
            Initializer(typeName: "Model", parameters: [.init(label: "value", name: "value", type: "Int")], accessLevel: "")
        ]
        
        XCTAssertEqual(result, expected)
    }
    
    // MARK: -
    
    func testParseAutoInjectableFactoryMethods() throws {
        let contents = """
        struct Model: AutoInjectable {
            
            static func makeInstance(value: Int) -> Model {
                Model()
            }
        }
        """
        
        let file = File(contents: contents)
        let parsedFile = try ParsedFile(file: file)!
        
        let result = parsedFile.autoInjectableFactoryMethods
        let expected = [
            FactoryMethod(typeName: "Model", parameters: [.init(label: "value", name: "value", type: "Int")], accessLevel: "")
        ]
        
        XCTAssertEqual(result, expected)
    }
}
