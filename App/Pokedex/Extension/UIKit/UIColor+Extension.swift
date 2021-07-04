//
//  UIColor+Extension.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/07/04.
//

import UIKit

extension UIColor {
    
    static func primaryColor(for type: Type) -> UIColor {
        switch type {
        case .normal: return .c9298A4
        case .fighting: return .cCE4265
        case .flying: return .c90A7DA
        case .poison: return .cA864C7
        case .ground: return .cDC7545
        case .rock: return .cC5B489
        case .bug: return .c92BC2C
        case .ghost: return .c516AAC
        case .steel: return .c52869D
        case .fire: return .cFB9B51
        case .water: return .c559EDF
        case .grass: return .c5FBC51
        case .electric: return .cEDD53E
        case .psychic: return .cF66F71
        case .ice: return .c70CCBD
        case .dragon: return .c0C69C8
        case .dark: return .c595761
        case .fairy: return .cEC8CE5
        }
    }
    
    static func secondaryColor(for type: Type) -> UIColor {
        switch type {
        case .normal: return .cA3A49E
        case .fighting: return .cE74347
        case .flying: return .cA6C2F2
        case .poison: return .cC261D4
        case .ground: return .cD29463
        case .rock: return .cD7CD90
        case .bug: return .cAFC836
        case .ghost: return .c7773D4
        case .steel: return .c58A6AA
        case .fire: return .cFBAE46
        case .water: return .c69B9E3
        case .grass: return .c5AC178
        case .electric: return .cFBE273
        case .psychic: return .cFE9F92
        case .ice: return .c8CDDD4
        case .dragon: return .c0180C7
        case .dark: return .c6E7587
        case .fairy: return .cF3A7E7
        }
    }
    
    static func gradientColor(for type: Type) -> [UIColor] {
        [UIColor.primaryColor(for: type), UIColor.secondaryColor(for: type)]
    }
}
