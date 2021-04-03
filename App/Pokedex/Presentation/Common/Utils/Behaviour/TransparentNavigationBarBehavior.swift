//
//  TransparentNavigationBarBehaviour.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/01/06.
//

import UIKit

public struct TransparentNavigationBarBehavior: ViewControllerLifecycleBehavior {
    
    func viewDidLoad(viewController: UIViewController) {
        viewController.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        viewController.navigationController?.navigationBar.shadowImage = UIImage()
    }
}
