//
//  PokemonDetailViewState.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/04/17.
//

import Foundation

struct PokemonDetailViewState {
    var backgroundType: Type?
    var masterPokemonState: LoadingState<MasterPokemonData, APIError> = .initial
    
    var masterPokemonData: MasterPokemonData? {
        switch masterPokemonState {
        case .completed(.success(let masterData)):
            return masterData
        default:
            return nil
        }
    }
    
    var imageUrl: URL? {
        switch masterPokemonState {
        case .completed(.success(let masterData)):
            let id = masterData.id
            return ApplicationConfiguration.current.spriteUrl(appending: "/pokemon/other/official-artwork/\(id).png")
        default:
            return nil
        }
    }
    
    var statsSections: StatsViewSections {
        switch masterPokemonState {
        case .completed(.success(let masterData)):
            return .from(masterData)
        default:
            return .empty
        }
    }
    
    var weaknessSection: WeaknessViewSections {
        switch masterPokemonState {
        case .completed:
            return .from()
        default:
            return .empty
        }
    }
}

// MARK: Sections

struct StatsViewData: Equatable {
    let stats: Stats
    let type: Type
}

typealias StatsViewSections = Sections<String, StatsViewData>

extension StatsViewSections {
    
    static func from(_ masterData: MasterPokemonData) -> StatsViewSections {
        let sections = StatsViewSections(
            sections: [
                Section(
                    model: "Stats",
                    elements: masterData.stats.map { StatsViewData(stats: $0, type: masterData.primaryType!) }
                )
            ]
        )
        
        return sections
    }
}

typealias WeaknessViewSections = Sections<String, Type>

extension WeaknessViewSections {
    
    static func from() -> WeaknessViewSections {
        let sections = WeaknessViewSections(
            sections: [
                Section(
                    model: "Weakness",
                    elements: [
                        .normal,   .fighting,  .flying,
                        .poison,   .ground,    .rock,
                        .bug,      .ghost,     .steel,
                        .fire,     .water,     .grass,
                        .electric, .psychic,   .ice,
                        .dragon,   .dark,      .fairy
                    ]
                )
            ]
        )
        
        return sections
    }
}
