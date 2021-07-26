//
//  MovesListDTO.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/07/23.
//

import Foundation

struct MovesListDTO: Codable {
    let count: Int
    let moves: [MovesListItemDTO]
    
    enum CodingKeys: String, CodingKey {
        case count
        case moves = "results"
    }
}

extension MovesListDTO {
    
    func toDomain() -> MovesList {
        MovesList(count: count, moves: moves.map { $0.toDomain() })
    }
}

struct MovesListItemDTO: Codable {
    let name: String
    let url: String
}

extension MovesListItemDTO {
    func toDomain() -> MovesListItem {
        MovesListItem(name: name, url: url)
    }
}
