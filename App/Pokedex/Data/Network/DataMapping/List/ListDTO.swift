//
//  ListDTO.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/10/16.
//

import Foundation

struct ListDTO: Codable {
    
    let count: Int
    let results: [ListObjectDTO]
}

extension ListDTO {
    
    func toDomain() -> List {
        List(count: count,
             results: results.map { $0.toDomain() })
    }
}

struct ListObjectDTO: Codable {
    
    let name: String
    let url: String
}

extension ListObjectDTO {
    func toDomain() -> ListObject {
        ListObject(name: name, url: url)
    }
}
