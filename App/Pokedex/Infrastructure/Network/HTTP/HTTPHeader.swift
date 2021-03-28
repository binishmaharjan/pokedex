//
//  HTTPHeader.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/03/25.
//

import Foundation

struct HTTPHeader: Hashable {
    
    struct Key: Hashable {
        
        let rawValue: String
        
        init(_ rawValue: String) {
            self.rawValue = rawValue
        }
    }
    
    let key: Key
    let value: String?
}
