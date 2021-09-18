//
//  ItemsDTO.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/09/14.
//

import Foundation

struct ItemsDTO: Codable {
    
    let name: String
    let id: Int
    let cost: Int
    
    func toDomain() -> Items {
        Items(name: name, id: id, price: cost)
    }
}
