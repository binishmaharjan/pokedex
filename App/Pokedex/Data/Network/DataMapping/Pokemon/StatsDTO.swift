//
//  StatsDTO.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/06/28.
//

import Foundation

struct StatsDTO: Codable {
    let baseStat: Int
    let effort: Int
    let stat: StatDTO

    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort, stat
    }
    
    func toDomain() -> Stats {
        .init(baseStat: baseStat,
              effort: effort,
              stat: stat.toDomain())
    }
}

// MARK: - Stat
struct StatDTO: Codable {
    let name: StatsName
    let url: String
    
    func toDomain() -> Stat {
        .init(name: name, url: url)
    }
}
