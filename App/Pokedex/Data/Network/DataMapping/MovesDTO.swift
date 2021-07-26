//
//  MovesDTO.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/07/23.
//

import Foundation

struct MovesDTO: Codable {
    
    let name: String
    let id: Int
    let type: TypeInfoDTO
    
    func toDomain() -> Moves {
        Moves(name: name, id: id, type: type.toDomain())
    }
}
