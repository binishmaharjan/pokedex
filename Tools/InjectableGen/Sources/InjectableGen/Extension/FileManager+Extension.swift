//
//  File.swift
//  
//
//  Created by hirano masaki on 2020/06/04.
//

import Foundation
import SourceKittenFramework

extension FileManager {
    
    func fileURLs(in directory: URL) -> [URL] {
        guard let enumrator = self.enumerator(at: directory, includingPropertiesForKeys: nil, options: [.skipsHiddenFiles], errorHandler: nil) else {
            return []
        }
        
        var urls: [URL] = []
        for case let url as URL in enumrator {
            urls.append(url)
        }
        
        return urls
    }
}
