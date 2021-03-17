//
//  File.swift
//  
//
//  Created by hirano masaki on 2020/06/04.
//

import Foundation
import SourceKittenFramework

struct Import: Hashable {
    
    static let DIKit = Import(moduleName: "DIKit")
    
    let moduleName: String

    static func imports(from file: File) throws -> [Import] {
        let syntaxMap = try SyntaxMap(file: file)
        let importTokenIndices = syntaxMap.tokens.enumerated()
            .compactMap { index, token -> Int? in
                guard token.type == "source.lang.swift.syntaxtype.keyword" else {
                    return nil
                }
                
                let view = file.contents.utf8
                let startIndex = view.index(view.startIndex, offsetBy: token.offset.value)
                let endIndex = view.index(startIndex, offsetBy: token.length.value)
                let value = String(view[startIndex..<endIndex])!
                return value == "import" ? index : nil
            }

        let importedModuleNames = importTokenIndices
            .compactMap { index -> String? in
                let identifierIndex = index + 1
                guard identifierIndex < syntaxMap.tokens.count else {
                    return nil
                }

                let token = syntaxMap.tokens[identifierIndex]
                guard token.type == "source.lang.swift.syntaxtype.identifier" else {
                    return nil
                }

                let view = file.contents.utf8
                let startIndex = view.index(view.startIndex, offsetBy: token.offset.value)
                let endIndex = view.index(startIndex, offsetBy: token.length.value)
                return String(view[startIndex..<endIndex])!
            }

        return importedModuleNames.map(Import.init(moduleName:))
    }
}

extension Import: Comparable {
    
    static func < (lhs: Import, rhs: Import) -> Bool {
        lhs.moduleName < rhs.moduleName
    }
}
