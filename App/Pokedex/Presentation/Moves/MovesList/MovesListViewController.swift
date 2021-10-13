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
        case moveDetail(Int, Type?)
    }
    
    // MARK: Private Properties
    private let resolver: AppResolver
    private var dismissLoading: WindowLoadingView.DismissTrigger?
    private var movesListView: MovesListView!
    private var viewModel: MovesListViewModel!
    
    // MARK: Lifecycle
    init(resolver: AppResolver, viewModel: MovesListViewModel) {
        self.resolver = resolver
        self.viewModel = viewModel
        self.movesListView = MovesListView(viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) { nil }
    
    override func loadView() {
        view = movesListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        bind()
        viewModel.fetchMovesFullList()
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
        movesListView.onPerform = { [weak self] action in
            guard let self = self else { return }
            self.perform(action: action)
        }
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
        case .moveDetail(let index, let type):
            let viewController = resolver.resolveMovesDetailViewController(currentIndex: index, backgroundType: type)
            
            viewController.modalPresentationStyle = .fullScreen
            
            self.present(viewController, animated: true)
        }
    }
}
