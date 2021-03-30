//
//  StoryboardInstantiable.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2020/12/31.
//

import UIKit

public protocol StoryboardInstantiable {}

public extension StoryboardInstantiable where Self: UIViewController {
    
    static func instantiateViewController() -> Self {
        let storyboard = UIStoryboard(name: className, bundle: nil)
        
        guard let viewController = storyboard.instantiateViewController(identifier: className) as? Self else {
            fatalError("Could not instantiate ViewController")
        }
        
        return viewController
    }
}
