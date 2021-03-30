//
//  AppRootViewController.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2020/12/31.
//

import UIKit

final class AppRootViewController: SingleContainerViewContainer, AutoInjectable {
    
    private let resolver: AppResolver
    
    init(resolver: AppResolver) {
        self.resolver = resolver
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        replace(makeSplashViewController(), animated: false)
    }
    
}

private extension AppRootViewController {

    func makeSplashViewController() -> SplashViewController {
        let splashViewController = resolver.resolveSplashViewController()
        splashViewController.onComplete = { [weak self] in
            self?.makeMainViewController()
        }

        return splashViewController
    }

    func makeMainViewController() {
        let mainViewController = resolver.resolveMainViewController()

        replace(mainViewController, animated: true)
    }
}
