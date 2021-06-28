//
//  Stats.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/06/28.
//

import Foundation

struct Stats: Equatable {
    let baseStat: Int
    let effort: Int
    let stat: Stat
}

// MARK: - Stat
struct Stat: Equatable {
    let name: StatsName
    let url: String
}

enum StatsName: String, Codable, Equatable {
    case hp = "hp"
    case attack = "attack"
    case defense = "defense"
    case specialAttack = "special-attack"
    case specialDefense = "special-defense"
    case speed = "speed"
    
    var displayText: String {
        switch self {
        case .hp: return "HP"
        case .attack: return "ATT"
        case .defense: return "DEF"
        case .specialAttack: return "SATT"
        case .specialDefense: return "SDEF"
        case .speed: return "SPD"
        }
    }
}

extension Stats {
    static func empty(_ name: StatsName) -> Stats {
        .init(baseStat: 0, effort: 0, stat: .init(name: name, url: ""))
    }
}

extension Array where Element == Stats {
    
    func fetch(_ name: StatsName) -> Stats {
        filter { $0.stat.name == name }.first ?? .empty(name)
    }
}
