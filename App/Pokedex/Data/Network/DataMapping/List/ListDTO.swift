//
//  ListDTO.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/10/16.
//

import Foundation

struct ListDTO: Codable {
    
    let count: Int
    let results: [ListItemDTO]
}

extension ListDTO {
    
    func toDomain() -> List {
        List(count: count,
             results: results.map { $0.toDomain() })
    }
}

struct ListItemDTO: Codable {
    
    let name: String
    let url: String
}

extension ListItemDTO {
    func toDomain() -> ListItem {
        ListItem(name: name, url: url)
    }
}
