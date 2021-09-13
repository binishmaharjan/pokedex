//
//  ItemsListDTO.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/09/14.
//

import Foundation

struct ItemsListDTO: Codable {
    let count: Int
    let items: [ItemsListItemDTO]
    
    enum CodingKeys: String, CodingKey {
        case count
        case items = "results"
    }
}

extension ItemsListDTO {
    func toDomain() -> ItemsList {
        ItemsList(count: count, items: items.map { $0.toDomain() })
    }
}

struct ItemsListItemDTO: Codable {
    let name: String
    let url: String
}

extension ItemsListItemDTO {
    func toDomain() -> ItemsListItem {
        ItemsListItem(name: name, url: url)
    }
}
