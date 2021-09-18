//
//  ItemsListViewController.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/09/14.
//

import UIKit

final class ItemsListViewController: UIViewController, AutoInjectable {
    
    // MARK: Enums
    enum Action {
        case itemDetail(Int)
    }
    
    // MARK: Private Properties
    private let resolver: AppResolver
    private var dismissLoading: WindowLoadingView.DismissTrigger?
    private var itemsListView: ItemsListView!
    private var viewModel: ItemsListViewModel!
    
    // MARK: Lifecycle
    init(resolver: AppResolver, viewModel: ItemsListViewModel) {
        self.resolver = resolver
        self.viewModel = viewModel
        self.itemsListView = ItemsListView(viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) { nil }
    
    override func loadView() {
        view = itemsListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        bind()
        viewModel.fetchItemFullList()
    }
}

// MARK: Setup
private extension ItemsListViewController {
    
    func setup() {
        addBehaviors([TransparentNavigationBarBehavior()])
        title = "Items"
        
        setupItemsListView()
    }
    
    func setupItemsListView() {
        itemsListView.onPerform = { [weak self] action in
            guard let self = self else { return }
            self.perform(action: action)
        }
    }
}

// MARK: Binding
private extension ItemsListViewController {
    
    func bind() {
        viewModel.loadingState.signal.observeValues { [weak self] loadingState in
            switch loadingState {
            case .loading(nextPage: false):
                self?.dismissLoading = WindowLoadingView.show()
                
            case .loading(nextPage: true):
                self?.itemsListView.showNextPageLoadingIndicator(isLoadingNextPage: true)
                
            case .success:
                self?.dismissLoading?()
                self?.itemsListView.showNextPageLoadingIndicator(isLoadingNextPage: false)
                
            case .failure:
                self?.dismissLoading?()
                self?.itemsListView.showNextPageLoadingIndicator(isLoadingNextPage: false)
                
            default:
                break
            }
        }
    }
}

// MARK: Actions
private extension ItemsListViewController {
    
    func perform(action: Action) {
        switch action {
        case .itemDetail:
            break
        }
    }
}
