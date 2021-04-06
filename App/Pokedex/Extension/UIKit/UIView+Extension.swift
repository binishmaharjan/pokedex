//
//  UIView+Extension.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/03/30.
//

import UIKit

// MARK: Effects
extension UIView {
    
    /// Add blur
    func addBlur() {
        let blurEffect = UIBlurEffect(style: .regular)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = bounds
        
        addSubview(blurView)
    }
    
    /// Add default gradient
    func applyGradient() {
        let gradient = CAGradientLayer()
        gradient.type = .axial
        gradient.colors = [
            UIColor.c6E95FD.cgColor,
            UIColor.c6FDEFA.cgColor,
            UIColor.c8DE061.cgColor,
            UIColor.c51E85E.cgColor
        ]
        gradient.startPoint = CGPoint(x: 0, y: 1)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        
        gradient.frame = bounds
        layer.addSublayer(gradient)
    }
}

// MARK: Xib
extension UIView {
    
    /// Load xib which self is file owner
    func loadOwnedXib(xibName: String? = nil) {
        let v = UINib(nibName: xibName ?? Self.className, bundle: nil).instantiate(withOwner: self, options: nil).first as! UIView
        v.frame = bounds
        addSubview(v)
        v.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}
