//
//  PokemonListViewController.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/03/31.
//

import UIKit

final class PokemonListViewController: UIViewController, AutoInjectable {
    
    private let pokemonListView: PokemonListView
    private let viewModel: PokemonListViewModel
    private var dismissLoading: WindowLoadingView.DismissTrigger?
    
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
        addBehaviors([TransparentNavigationBarBehavior()])
        title = "Pokemon"
        
        bind()
        
        viewModel.fetchPokemonList()
    }
}

extension PokemonListViewController {
    
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
