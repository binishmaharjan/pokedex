//
//  PokemonListDTO.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/04/02.
//

import Foundation

//struct PokemonListDTO: Codable {
//    let count: Int
//    let pokemons: [PokemonListItemDTO]
//    
//    enum CodingKeys: String, CodingKey {
//        case count
//        case pokemons = "results"
//    }
//}
//
//extension PokemonListDTO {
//    
//    func toDomain() -> PokemonList {
//        PokemonList(count: count, pokemons: pokemons.map { $0.toDomain() })
//    }
//}
//
//struct PokemonListItemDTO: Codable {
//    let name: String
//    let url: String
//}
//
//extension PokemonListItemDTO {
//    
//    func toDomain() -> PokemonListItem {
//        PokemonListItem(name: name, url: url)
//    }
//}
