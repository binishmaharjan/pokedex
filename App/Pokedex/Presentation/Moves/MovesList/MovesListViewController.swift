//
//  MovesListViewController.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/07/23.
//

import UIKit

final class MovesListViewController: UIViewController, AutoInjectable {
    
    // MARK: Enums
    enum Action {
        case moveDetail
    }
    
    // MARK: Private Properites
    private let resolver: AppResolver
    private var dismissLoading: WindowLoadingView.DismissTrigger?
    private var movesListView: PokemonListView!
    private var viewModel: PokemonListViewModel!
    
    // MARK: Lifecycle
    init(resolver: AppResolver) {
        self.resolver = resolver
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

// MARK: Setup
private extension MovesListViewController {
    
    func setup() {
        addBehaviors([TransparentNavigationBarBehavior()])
        title = "Moves"
        
        setupMovesListView()
    }
    
    func setupMovesListView() {
        //TODO
    }
}

// MARK: Binding
private extension MovesListViewController {
    
    func bind() {
        viewModel.loadingState.signal.observeValues { [weak self] (loadingState) in
            switch loadingState {
            case .loading(nextPage: false):
                self?.dismissLoading = WindowLoadingView.show()
                
            case .loading(nextPage: true):
                self?.movesListView.showNextPageLoadingIndicator(isLoadingNextPage: true)
                
            case .success:
                self?.dismissLoading?()
                self?.movesListView.showNextPageLoadingIndicator(isLoadingNextPage: false)
                
            case .failure:
                self?.dismissLoading?()
                self?.movesListView.showNextPageLoadingIndicator(isLoadingNextPage: false)
                
            default:
                break
            }
        }
    }
}

// MARK: Actions
private extension MovesListViewController {
    
    func perform(action: Action) {
        switch action {
        case .moveDetail:
            break
        }
    }
}
