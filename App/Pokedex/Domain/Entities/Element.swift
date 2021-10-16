//
//  Element.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/04/03.
//

import Foundation

struct Element: Equatable {
    let slot: Int
    let type: TypeInfo
}

struct TypeInfo: Equatable  {
    let name: Type
    let url: String
}

enum Type: String, Codable, Equatable {
    
    case normal,   fighting, flying
    case poison,   ground,   rock
    case bug,      ghost,    steel
    case fire,     water,    grass
    case electric, psychic,  ice
    case dragon,   dark,     fairy
    
    
    var weakness: [Type: Double] {
        switch self {
        case .normal:
            return [
                .normal: 1.0,   .fighting: 2.0,  .flying: 1.0,
                .poison: 1.0,   .ground: 1.0,    .rock: 1.0,
                .bug: 1.0,      .ghost: 0.0,     .steel: 1.0,
                .fire: 1.0,     .water: 1.0,     .grass: 1.0,
                .electric: 1.0, .psychic: 1.0,   .ice: 1.0,
                .dragon: 1.0,   .dark: 1.0,      .fairy: 1.0
            ]
        case .fighting:
            return [
                .normal: 1.0,   .fighting: 1.0,  .flying: 2.0,
                .poison: 1.0,   .ground: 1.0,    .rock: 0.5,
                .bug: 0.5,     .ghost: 1.0,     .steel: 1.0,
                .fire: 1.0,     .water: 1.0,     .grass: 1.0,
                .electric: 1.0, .psychic: 2.0,   .ice: 1.0,
                .dragon: 1.0,   .dark: 0.5,      .fairy: 2.0
            ]
        case .flying:
            return [
                .normal: 1.0,   .fighting: 0.5, .flying: 1.0,
                .poison: 1.0,   .ground: 0.0,    .rock: 2.0,
                .bug: 0.5,     .ghost: 1.0,     .steel: 1.0,
                .fire: 1.0,     .water: 1.0,     .grass: 0.5,
                .electric: 2.0, .psychic: 1.0,   .ice: 2.0,
                .dragon: 1.0,   .dark: 1.0,      .fairy: 1.0
            ]
        case .poison:
            return [
                .normal: 1.0,   .fighting: 0.5,  .flying: 1.0,
                .poison: 0.5,   .ground: 2.0,    .rock: 1.0,
                .bug: 0.5,      .ghost: 1.0,     .steel: 1.0,
                .fire: 1.0,     .water: 1.0,     .grass: 0.5,
                .electric: 1.0, .psychic: 2.0,   .ice: 1.0,
                .dragon: 1.0,   .dark: 1.0,      .fairy: 0.5
            ]
        case .ground:
            return [
                .normal: 1.0,   .fighting: 1.0,  .flying: 1.0,
                .poison: 0.5,   .ground: 1.0,    .rock: 0.5,
                .bug: 1.0,      .ghost: 1.0,     .steel: 1.0,
                .fire: 1.0,     .water: 2.0,     .grass: 2.0,
                .electric: 0.0, .psychic: 1.0,   .ice: 2.0,
                .dragon: 1.0,   .dark: 1.0,      .fairy: 1.0
            ]
        case .rock:
            return [
                .normal: 0.5,   .fighting: 2.0,  .flying: 0.5,
                .poison: 0.5,   .ground: 2.0,    .rock: 1.0,
                .bug: 1.0,      .ghost: 1.0,     .steel: 2.0,
                .fire: 0.5,     .water: 2.0,     .grass: 2.0,
                .electric: 1.0, .psychic: 1.0,   .ice: 1.0,
                .dragon: 1.0,   .dark: 1.0,      .fairy: 1.0
            ]
        case .bug:
            return [
                .normal: 1.0,   .fighting: 0.5,  .flying: 2.0,
                .poison: 1.0,   .ground: 0.5,    .rock: 2.0,
                .bug: 1.0,      .ghost: 1.0,     .steel: 1.0,
                .fire: 2.0,     .water: 1.0,     .grass: 0.5,
                .electric: 1.0, .psychic: 1.0,   .ice: 1.0,
                .dragon: 1.0,   .dark: 1.0,      .fairy: 1.0
            ]
        case .ghost:
            return [
                .normal: 0.0,   .fighting: 0.0,  .flying: 1.0,
                .poison: 0.5,   .ground: 1.0,    .rock: 1.0,
                .bug: 0.5,      .ghost: 2.0,     .steel: 1.0,
                .fire: 1.0,     .water: 1.0,     .grass: 1.0,
                .electric: 1.0, .psychic: 1.0,   .ice: 1.0,
                .dragon: 1.0,   .dark: 2.0,      .fairy: 1.0
            ]
        case .steel:
            return [
                .normal: 0.5,   .fighting: 2.0,  .flying: 0.5,
                .poison: 0.0,   .ground: 2.0,    .rock: 0.5,
                .bug: 0.5,      .ghost: 1.0,     .steel: 0.5,
                .fire: 2.0,     .water: 1.0,     .grass: 0.5,
                .electric: 1.0, .psychic: 0.5,   .ice: 0.5,
                .dragon: 0.5,   .dark: 1.0,      .fairy: 0.5
            ]
        case .fire:
            return [
                .normal: 1.0,   .fighting: 1.0,  .flying: 1.0,
                .poison: 1.0,   .ground: 2.0,    .rock: 2.0,
                .bug: 0.5,      .ghost: 1.0,     .steel: 0.5,
                .fire: 0.5,     .water: 2.0,     .grass: 0.5,
                .electric: 1.0, .psychic: 1.0,   .ice: 0.5,
                .dragon: 1.0,   .dark: 1.0,      .fairy: 0.5
            ]
        case .water:
            return [
                .normal: 1.0,   .fighting: 1.0,  .flying: 1.0,
                .poison: 1.0,   .ground: 1.0,    .rock: 1.0,
                .bug: 1.0,      .ghost: 1.0,     .steel: 0.5,
                .fire: 0.5,     .water: 0.5,     .grass: 2.0,
                .electric: 2.0, .psychic: 1.0,   .ice: 0.5,
                .dragon: 1.0,   .dark: 1.0,      .fairy: 1.0
            ]
        case .grass:
            return [
                .normal: 1.0,   .fighting: 1.0,  .flying: 2.0,
                .poison: 2.0,   .ground: 0.5,    .rock: 1.0,
                .bug: 2.0,      .ghost: 1.0,     .steel: 1.0,
                .fire: 2.0,     .water: 0.5,     .grass: 0.5,
                .electric: 0.5, .psychic: 1.0,   .ice: 2.0,
                .dragon: 1.0,   .dark: 1.0,      .fairy: 1.0
            ]
        case .electric:
            return [
                .normal: 1.0,   .fighting: 1.0,  .flying: 0.5,
                .poison: 1.0,   .ground: 2.0,    .rock: 1.0,
                .bug: 1.0,      .ghost: 1.0,     .steel: 0.5,
                .fire: 1.0,     .water: 1.0,     .grass: 1.0,
                .electric: 0.5, .psychic: 1.0,   .ice: 1.0,
                .dragon: 1.0,   .dark: 1.0,      .fairy: 1.0
            ]
        case .psychic:
            return [
                .normal: 1.0,   .fighting: 0.5,  .flying: 1.0,
                .poison: 1.0,   .ground: 1.0,    .rock: 1.0,
                .bug: 2.0,      .ghost: 2.0,     .steel: 1.0,
                .fire: 1.0,     .water: 1.0,     .grass: 1.0,
                .electric: 1.0, .psychic: 0.5,   .ice: 1.0,
                .dragon: 1.0,   .dark: 2.0,      .fairy: 1.0
            ]
        case .ice:
            return [
                .normal: 1.0,   .fighting: 2.0,  .flying: 1.0,
                .poison: 1.0,   .ground: 1.0,    .rock: 2.0,
                .bug: 1.0,      .ghost: 1.0,     .steel: 2.0,
                .fire: 2.0,     .water: 1.0,     .grass: 1.0,
                .electric: 1.0, .psychic: 1.0,   .ice: 0.5,
                .dragon: 1.0,   .dark: 1.0,      .fairy: 1.0
            ]
        case .dragon:
            return [
                .normal: 1.0,   .fighting: 1.0,  .flying: 1.0,
                .poison: 1.0,   .ground: 1.0,    .rock: 1.0,
                .bug: 1.0,      .ghost: 1.0,     .steel: 1.0,
                .fire: 0.5,     .water: 0.5,     .grass: 0.5,
                .electric: 0.5, .psychic: 1.0,   .ice: 2.0,
                .dragon: 2.0,   .dark: 1.0,      .fairy: 2.0
            ]
        case .dark:
            return [
                .normal: 1.0,   .fighting: 2.0,  .flying: 1.0,
                .poison: 1.0,   .ground: 1.0,    .rock: 1.0,
                .bug: 2.0,      .ghost: 0.5,     .steel: 1.0,
                .fire: 1.0,     .water: 1.0,     .grass: 1.0,
                .electric: 1.0, .psychic: 0.0,   .ice: 1.0,
                .dragon: 1.0,   .dark: 0.5,      .fairy: 2.0
            ]
        case .fairy:
            return [
                .normal: 1.0,   .fighting: 0.5,  .flying: 1.0,
                .poison: 2.0,   .ground: 1.0,    .rock: 1.0,
                .bug: 0.5,      .ghost: 1.0,     .steel: 2.0,
                .fire: 1.0,     .water: 1.0,     .grass: 1.0,
                .electric: 1.0, .psychic: 1.0,   .ice: 1.0,
                .dragon: 0.0,   .dark: 0.5,      .fairy: 1.0
            ]
        }
    }
}


