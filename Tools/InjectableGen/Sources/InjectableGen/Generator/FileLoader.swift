//
//  File.swift
//  
//
//  Created by hirano masaki on 2020/06/04.
//

import Foundation
import SourceKittenFramework

struct FileLoader {
    
    private let directoryURL: URL
    private let exclusivePaths: [String]
    private let fileManager = FileManager.default
    
    init(directoryURL: URL, exclusivePaths: [String]) {
        self.directoryURL = directoryURL
        self.exclusivePaths = exclusivePaths.map(directoryURL.appendingPathComponent).map(\.path)
    }
    
    func loadFiles() -> [File] {
        let fileURLs = fileManager
            .fileURLs(in: directoryURL)
            .filter(isInclusive)
        
        let files = fileURLs.compactMap { url in
            File(path: url.path)
        }
        
        return files
    }
    
    private func isInclusive(_ url: URL) -> Bool {
        url.pathExtension == "swift" && !exclusivePaths.contains(where: url.path.hasPrefix)
    }
}
