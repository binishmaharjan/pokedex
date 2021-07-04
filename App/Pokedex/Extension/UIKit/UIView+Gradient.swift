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
        case type(Type)
        
        var colors: [UIColor] {
            switch self {
            case .app: return [.c84E090, .c75DEDD]
            case .border: return [.c6E95FD, .c6FDEFA, .c8DE061, .c51E85E]
            case .type(let type): return UIColor.gradientColor(for: type)
            }
        }
    }
    
    func applyGradient(for gradient: GradientType, type: CAGradientLayerType = .axial) {
        applyGradient(colors: gradient.colors, type: type)
    }
    
    func applyGradient(with type: Type) {
        applyGradient(for: .type(type))
    }
}
