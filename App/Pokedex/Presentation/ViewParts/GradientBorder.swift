//
//  GradientBorder.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/03/30.
//

import UIKit

/// https://marcosantadev.com/calayer-auto-layout-swift/
final class GradientView: UIView {
    
    override public class var layerClass: Swift.AnyClass {
        return CAGradientLayer.self
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        guard let gradientLayer = self.layer as? CAGradientLayer else { return }
        gradientLayer.colors = [
            UIColor.blue.cgColor,
            UIColor.cyan.cgColor
        ]
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    init() {
        super.init(frame: .zero)
        
        guard let gradientLayer = self.layer as? CAGradientLayer else { return }
    
        gradientLayer.type = .axial
        gradientLayer.colors = [
            UIColor.c6E95FD.cgColor,
            UIColor.c6FDEFA.cgColor,
            UIColor.c8DE061.cgColor,
            UIColor.c51E85E.cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 1)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
    }
}
