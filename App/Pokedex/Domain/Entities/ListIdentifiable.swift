//
//  ListIdentifiable.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/10/16.
//

import Foundation

protocol ListIdentifiable {
    var url: String { get }
}

extension ListIdentifiable {
    
    var id: Int {
        guard let lastString = url.split(separator: "/").last,
              let id = Int(lastString) else {
            return 0
        }
        
        return id
    }
}
