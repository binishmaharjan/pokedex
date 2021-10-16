//
//  MainViewController.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/03/30.
//

import UIKit

final class MainViewController: UITabBarController, AutoInjectable {
    
    private let resolver: AppResolver
    private let apiClient: APIClient
    private let thickness: CGFloat = 4
    private var gradientBorder = GradientView()
    private var flag = true
    
    init(resolver: AppResolver) {
        self.resolver = resolver
        self.apiClient = resolver.resolveAPIClient()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
        let viewControllers = makeChildren()
        setViewControllers(viewControllers, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if isBeingPresented || isMovingToParent {
            setupGradientBorder()
        }
    }
    
    private func setupGradientBorder() {
        view.addSubview(gradientBorder)
        
        gradientBorder.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            gradientBorder.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gradientBorder.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gradientBorder.bottomAnchor.constraint(equalTo: tabBar.topAnchor),
            gradientBorder.heightAnchor.constraint(equalToConstant: thickness)
        ])
    }
}

private extension MainViewController {
    
    func setup() {
        tabBar.barTintColor = UIColor.clear
        tabBar.tintColor = UIColor.black
        tabBar.backgroundImage = UIImage() // Clear TabBarColor
        tabBar.shadowImage = UIImage() // Clear default tab bar border
        tabBar.layer.masksToBounds = true
    }
    
    func makeChildren() -> [UIViewController] {
        [
            UINavigationController(
                rootViewController: resolver.resolvePokemonListViewController(
                    listRepository: resolver.resolvePokemonRepository()
                )
            )
            .withTabBarItem(.iconPokemon, "Pokemon"),
            
            UINavigationController(
                rootViewController: resolver.resolveItemsListViewController(
                    listRepository: resolver.resolveItemsRepository()
                )
            )
            .withTabBarItem(.iconItems, "Items"),
            
            UINavigationController(rootViewController: resolver.resolveMovesListViewController())
                    .withTabBarItem(.iconMoves, "Moves"),
        ]
    }
}
