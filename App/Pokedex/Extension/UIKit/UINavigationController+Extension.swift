//
//  UINavigationController+Extension.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/03/30.
//

import UIKit

extension UINavigationController {
    
    func withTabBarItem(_ selectedImage: UIImage, _ image: UIImage, _ title: String) -> UINavigationController {
        tabBarItem.title = title
        tabBarItem.image = image
        tabBarItem.selectedImage = selectedImage.withRenderingMode(.alwaysOriginal)
        
        return self
    }
    
    func withTabBarItem(_ image: UIImage, _ title: String) -> UINavigationController {
        tabBarItem.title = title
        tabBarItem.image = image
        
        return self
    }
}
