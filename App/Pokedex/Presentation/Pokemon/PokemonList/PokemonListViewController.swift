//
//  PokemonListViewController.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/03/31.
//

import UIKit

final class PokemonListViewController: UIViewController, AutoInjectable {
    // MARK: Enums
    enum Action {
        case pokemonDetail
    }
    
    // MARK: Private Properties
    private let pokemonListView: PokemonListView
    private let viewModel: PokemonListViewModel
    private var dismissLoading: WindowLoadingView.DismissTrigger?
    
    // MARK: Lifecycle
    init(viewModel: PokemonListViewModel) {
        self.viewModel = viewModel
        self.pokemonListView = PokemonListView(viewModel: viewModel)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
       nil
    }
    
    override func loadView() {
        view = pokemonListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
        bind()
        
        viewModel.fetchPokemonFullList()
    }
}

// MARK: Setup
private extension PokemonListViewController {
    
    func setup() {
        addBehaviors([TransparentNavigationBarBehavior()])
        title = "Pokemon"
        
        setupPokemonListView()
    }
    
    func setupPokemonListView() {
        pokemonListView.onPerform = { [weak self] action in
            
            guard let self = self else { return }
            
            self.perform(action: action)
        }
    }
}

// MARK: Binding
private extension PokemonListViewController {
    
    func bind() {
        viewModel.loadingState.signal.observeValues { [weak self] (loadingState) in
            switch loadingState {
            case .loading(nextPage: false):
                self?.dismissLoading = WindowLoadingView.show()
                
            case .loading(nextPage: true):
                self?.pokemonListView.showNextPageLoadingIndicator(isLoadingNextPage: true)
                
            case .success:
                self?.dismissLoading?()
                self?.pokemonListView.showNextPageLoadingIndicator(isLoadingNextPage: false)
                
            case .failure:
                self?.dismissLoading?()
                self?.pokemonListView.showNextPageLoadingIndicator(isLoadingNextPage: false)
                
            default:
                break
            }
        }
    }
}

// MARK: Actions
private extension PokemonListViewController {
    
    func perform(action: Action)  {
        switch action {
        case .pokemonDetail:
            let viewController = UIViewController()
            viewController.view.backgroundColor = .red
            self.present(viewController, animated: true)
        }
    }
}
