//
//  BaseViewController.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/10/23.
//

import UIKit

final class ListViewController: UIViewController, AutoInjectable {
    
    // MARK: Enums
    enum Action {
        case pokemonDetail(Int, Type?)
        case itemsDetail(Int)
        case moveDetail(Type?)
    }
    
    // MARK: Private Properties
    private let resolver: AppResolver
    private var viewModel: ListViewModel!
    private var baseView: ListView!
    private var dismissLoading: WindowLoadingView.DismissTrigger?
    
    // MARK: LifeCycle
    init(resolver: AppResolver, viewModel: ListViewModel) {
        self.resolver = resolver
        self.viewModel = viewModel
        self.baseView = ListView(viewModel: viewModel)
        
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) { nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        bindLoadingState()
        viewModel.fetchList()
    }
    
    override func loadView() {
        view = baseView
    }
}

// MARK: Setup
private extension ListViewController {
    
    func setup() {
        addBehaviors([TransparentNavigationBarBehavior()])
        title = "Pokemon"
        
        setupListView()
    }
    
    func setupListView() {
        baseView.onPerform = { [weak self] action in
            guard let self = self else { return }
            
            self.perform(action: action)
        }
    }
}

// MARK: Bind
extension ListViewController {
    
    func bindLoadingState() {
        viewModel.loadingState.signal.observeValues { [weak self] (loadingState) in
            
            guard let self = self else { return }
            
            switch loadingState {
            case .loading(nextPage: false):
                self.dismissLoading = WindowLoadingView.show()
                
            case .loading(nextPage: true):
                self.baseView.showNextPageLoadingIndicator(isLoadingNextPage: true)
                
            case .success:
                self.dismissLoading?()
                self.baseView.showNextPageLoadingIndicator(isLoadingNextPage: false)
                
            case .failure(let error):
                self.dismissLoading?()
                self.baseView.showNextPageLoadingIndicator(isLoadingNextPage: false)
                self.showErrorAlert(error: error)
                
            default:
                break
            }
        }
    }
}

// MARK: Error
extension ListViewController {
    
    func showErrorAlert(error: AnyLoadingState.Failure) {
        let alertController = UIAlertController(title: error.title, message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: error.actionName, style: .default)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(action)
        alertController.addAction(cancel)
        
        present(alertController, animated: true)
    }
}

// MARK: Actions
private extension ListViewController {
    
    func perform(action: Action) {
        switch action {
        case let .pokemonDetail(pokemonId, backgroundType):
            let viewController = resolver.resolvePokemonDetailViewController(
                pokemonId: pokemonId,
                backgroundType: backgroundType
            )
            viewController.modalPresentationStyle = .fullScreen
            
            self.present(viewController, animated: true)
        default:
            break
        }
    }
}
