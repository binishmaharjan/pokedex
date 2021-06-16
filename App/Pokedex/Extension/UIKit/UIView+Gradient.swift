//
//  UIView+Gradient.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/04/17.
//

import UIKit

extension UIView {
    
    enum GradientType {
        case app
        case border
        
        case water
        case normal
        case fighting
        case flying
        case poison
        case ground
        case rock
        case bug
        case ghost
        case steel
        case fire
        case grass
        case electric
        case psychic
        case ice
        case dragon
        case dark
        case fairy
        case shadow
        case unknown
        
        var colors: [UIColor] {
            switch self {
            case .app: return [.c84E090, .c75DEDD]
            case .border: return [.c6E95FD, .c6FDEFA, .c8DE061, .c51E85E]
            case .water: return [.c559EDF, .c69B9E3]
            case .normal: return [.c9298A4, .cA3A49E]
            case .fighting: return [.cCE4265, .cE74347]
            case .flying: return [.c90A7DA, .cA6C2F2]
            case .poison: return [.cA864C7, .cC261D4]
            case .ground: return [.cDC7545, .cD29463]
            case .rock: return [.cC5B489, .cD7CD90]
            case .bug: return [.c92BC2C, .cAFC836]
            case .ghost: return [.c516AAC, .c7773D4]
            case .steel: return [.c52869D, .c58A6AA]
            case .fire: return [.cFB9B51, .cFBAE46]
            case .grass: return [.c5FBC51, .c5AC178]
            case .electric: return [.cEDD53E, .cFBE273]
            case .psychic: return [.cF66F71, .cFE9F92]
            case .ice: return [.c70CCBD, .c8CDDD4]
            case .dragon: return [.c0C69C8, .c0180C7]
            case .dark: return [.c595761, .c6E7587]
            case .fairy: return [.cEC8CE5, .cF3A7E7]
            case .unknown: return [] //
            case .shadow: return [] //
            }
        }
    }
    
    func applyGradient(for gradient: GradientType, type: CAGradientLayerType = .axial) {
        applyGradient(colors: gradient.colors, type: type)
    }
    
    func applyGradient(with typeName: TypeName) {
        switch typeName {
        case .normal: applyGradient(for: .normal)
        case .fighting: applyGradient(for: .fighting)
        case .flying: applyGradient(for: .flying)
        case .poison: applyGradient(for: .poison)
        case .ground: applyGradient(for: .ground)
        case .rock: applyGradient(for: .rock)
        case .bug: applyGradient(for: .bug)
        case .ghost: applyGradient(for: .ghost)
        case .steel: applyGradient(for: .steel)
        case .fire: applyGradient(for: .fire)
        case .water: applyGradient(for: .water)
        case .grass: applyGradient(for: .grass)
        case .electric: applyGradient(for: .electric)
        case .psychic: applyGradient(for: .psychic)
        case .ice: applyGradient(for: .ice)
        case .dragon: applyGradient(for: .dragon)
        case .dark: applyGradient(for: .dark)
        case .fairy: applyGradient(for: .fairy)
        case .unknown: applyGradient(for: .unknown)
        case .shadow: applyGradient(for: .shadow)
        }
    }
}
