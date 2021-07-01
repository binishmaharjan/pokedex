//
//  UIImage+Extension.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/04/03.
//

import UIKit

extension UIImage {
    
    enum ImageType {
        case icon
        case tag
    }
    static func from(_ type: Type?, imageType: ImageType = .icon) -> UIImage? {
        guard let type = type else {
            return nil
        }
        
        switch type {
        case .normal:
            return imageType == .icon ? .iconNormal : .tagNormal
        case .fighting:
            return imageType == .icon ? .iconFighting : .tagFight
        case .flying:
            return imageType == .icon ? .iconFlying : .tagFlying
        case .poison:
            return imageType == .icon ? .iconPoison : .tagPoison
        case .ground:
            return imageType == .icon ? .iconGround : .tagGround
        case .rock:
            return imageType == .icon ? .iconRock : .tagRock
        case .bug:
            return imageType == .icon ? .iconBug : .tagBug
        case .ghost:
            return imageType == .icon ? .iconGhost : .tagGhost
        case .steel:
            return imageType == .icon ? .iconSteel : .tagSteel
        case .fire:
            return imageType == .icon ? .iconFire : .tagFire
        case .water:
            return imageType == .icon ? .iconWater : .tagWater
        case .grass:
            return imageType == .icon ? .iconGrass : .tagGrass
        case .electric:
            return imageType == .icon ? .iconElectric : .tagElectric
        case .psychic:
            return imageType == .icon ? .iconPsychic : .tagPsychic
        case .ice:
            return imageType == .icon ? .iconIce : .tagIce
        case .dragon:
            return imageType == .icon ? .iconDragon : .tagDragon
        case .dark:
            return imageType == .icon ? .iconDark : .tagDark
        case .fairy:
            return imageType == .icon ? .iconFairy : .tagFairy
        }
    }
}
