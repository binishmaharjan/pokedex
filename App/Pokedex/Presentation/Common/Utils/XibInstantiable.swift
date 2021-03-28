//
//  XibInstantiable.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/01/05.
//

import UIKit

public protocol XibInstantiable { }

public extension XibInstantiable where Self: UIView {
    
    static func loadView() -> Self {
        guard let view = UINib(nibName: className, bundle: nil)
                        .instantiate(withOwner: self, options: nil).first as? Self else {
            fatalError("Failed to instantiate view")
        }
        
        return view
    }
}
