//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/04/14.
//

import UIKit

final class PokemonDetailViewController: UIViewController, AutoInjectable {
    // MARK: Enums
    enum Action {
        case close
    }
    
    // MARK: Private Properties
    private let resolver: AppResolver
    private let viewModel: PokemonDetailViewModel
    private let pokemonDetailView: PokemonDetailView
    private var dismissLoading: WindowLoadingView.DismissTrigger?
    
    // MARK: LifeCycle
    init(viewModel: PokemonDetailViewModel, resolver: AppResolver) {
        self.viewModel = viewModel
        self.pokemonDetailView = PokemonDetailView(viewModel: viewModel)
        self.resolver = resolver
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    override func loadView() {
        view = pokemonDetailView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
        bind()
    }
}

// MARK: Setup
private extension PokemonDetailViewController {
    
    func setup() {
        
        setupPokemonDetailView()
        
        setupPageViewController()
    }
    
    func setupPokemonDetailView() {
        pokemonDetailView.perform = { [weak self] action in
            
            guard let self = self else { return }
            
            self.perform(action: action)
        }
    }
    
    func setupPageViewController() {
        
        let pageViewController = PageViewController()
        
        addChild(pageViewController)
        
        pageViewController.dataSource = self
        
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        pokemonDetailView.contentView.addSubview(pageViewController.view)
        
        NSLayoutConstraint.activate([
            pageViewController.view.topAnchor.constraint(equalTo: pokemonDetailView.contentView.topAnchor),
            pageViewController.view.bottomAnchor.constraint(equalTo: pokemonDetailView.contentView.bottomAnchor),
            pageViewController.view.leadingAnchor.constraint(equalTo: pokemonDetailView.contentView.leadingAnchor),
            pageViewController.view.trailingAnchor.constraint(equalTo: pokemonDetailView.contentView.trailingAnchor),
        ])
        
        let viewController = resolver.resolvePokemonDetailContentViewController(pokemonId: viewModel.currentIndex)
        
        pageViewController.setViewControllers([viewController], direction: .forward, animated: true)
    }
}

// MARK: Bind
private extension PokemonDetailViewController {
    
    func bind() {
        
    }
}

// MARK: Actions
private extension PokemonDetailViewController {
    
    func perform(action: Action) {
        
        switch action {
        case .close:
            self.dismiss(animated: true)
        }
    }
}

// MARK: PageView DataSource
extension PokemonDetailViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentViewController = viewController as? PokemonDetailContentViewController else {
            return nil
        }
        
        let nextIndex = currentViewController.currentIndex - 1
        let nextViewController = resolver.resolvePokemonDetailContentViewController(pokemonId: nextIndex)
        viewModel.currentIndex = nextIndex
        
        return nextViewController
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let currentViewController = viewController as? PokemonDetailContentViewController else {
            return nil
        }
        
        let nextIndex = currentViewController.currentIndex + 1
        let nextViewController = resolver.resolvePokemonDetailContentViewController(pokemonId: nextIndex)
        viewModel.currentIndex = nextIndex
        
        return nextViewController
    }
}
