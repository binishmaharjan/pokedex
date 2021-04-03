//
//  URL+Extension.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/03/28.
//

import Foundation

extension URL {
    
    static let baseURL = ApplicationConfiguration.current.apiServerUrl
    
    static let documents = URL(fileURLWithPath: NSHomeDirectory()).appendingPathComponent("Documents")
    static let log = documents.appendingPathComponent("pokedex.log")
}
