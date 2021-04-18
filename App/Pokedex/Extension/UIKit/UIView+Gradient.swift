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
        
        var colors: [UIColor] {
            switch self {
            case .app:
                return [UIColor.c84E090, UIColor.c75DEDD]
            case .border:
                return [.c6E95FD, .c6FDEFA, .c8DE061, .c51E85E]
            }
        }
    }
    
    
    func applyGradient(for gradient: GradientType, type: CAGradientLayerType = .axial) {
        applyGradient(colors: gradient.colors, type: type)
    }
}
