//
//  UIImage+Extension.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/04/03.
//

import UIKit

extension UIImage {
    
    static func from(_ type: TypeName?) -> UIImage? {
        guard let type = type else {
            return nil
        }
        
        switch type {
        case .normal:
            return .iconNormal
        case .fighting:
            return .iconFighting
        case .flying:
            return .iconFlying
        case .poison:
            return .iconPoison
        case .ground:
            return .iconGround
        case .rock:
            return .iconRock
        case .bug:
            return .iconBug
        case .ghost:
            return .iconGhost
        case .steel:
            return .iconSteel
        case .fire:
            return .iconFire
        case .water:
            return .iconWater
        case .grass:
            return .iconGrass
        case .electric:
            return .iconElectric
        case .psychic:
            return .iconPsychic
        case .ice:
            return .iconIce
        case .dragon:
            return .iconDragon
        case .dark:
            return .iconDark
        case .fairy:
            return .iconFairy
        case .unknown:
           return nil
        case .shadow:
           return nil
        }
    }
}
