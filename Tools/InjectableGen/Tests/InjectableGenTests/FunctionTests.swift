//
//  File.swift
//  
//
//  Created by hirano masaki on 2020/06/05.
//

import Foundation
import XCTest
import SourceKittenFramework

@testable import InjectableGen

final class FunctionTests: XCTestCase {
    
    func testParse() throws {
        let contents = """
        public func test(value1: Int, value2 value2: Int, _ value3: Int) -> Int {
            0
        }
        """
        
        let structure = try Structure(file: File(contents: contents)).substructures[0]
        let function = Function(structure: structure)
        let expected = Function(
            name: "test(value1:value2:_:)",
            returnType: "Int",
            parameters: [
                .init(label: "value1", name: "value1", type: "Int"),
                .init(label: "value2", name: "value2", type: "Int"),
                .init(label: "_", name: "value3", type: "Int"),
            ],
            isStatic: false,
            accessLevel: "public"
        )
        
        XCTAssertEqual(function, expected)
    }
}
