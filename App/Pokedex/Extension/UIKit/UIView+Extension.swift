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
        
        insertSubview(blurView, at: 0)
    }
    
    /// Add default gradient
    func applyGradient(colors: [UIColor], type: CAGradientLayerType) {
        let gradient = CAGradientLayer()
        gradient.type = type
        gradient.colors = colors.map(\.cgColor)
        gradient.startPoint = CGPoint(x: 0, y: 1)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        
        gradient.frame = bounds

        layer.sublayers?.first { $0 is CAGradientLayer }?.removeFromSuperlayer()
        layer.insertSublayer(gradient, at: 0)
        setNeedsDisplay()
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

// MARK: Layer
extension UIView {
    
    func roundCorners(corners: CACornerMask, radius: CGFloat) {
        layer.cornerRadius = radius
        layer.maskedCorners = corners
    }
}
