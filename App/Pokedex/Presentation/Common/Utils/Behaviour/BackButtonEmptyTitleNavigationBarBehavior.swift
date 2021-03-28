//
//  BackButtonEmptyTitleNavigationBarBehavior.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/01/06.
//

import UIKit

public struct BackButtonEmptyTitleNavigationBarBehavior: ViewControllerLifecycleBehavior {
    
    func viewDidLoad(viewController: UIViewController) {

        viewController.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}
