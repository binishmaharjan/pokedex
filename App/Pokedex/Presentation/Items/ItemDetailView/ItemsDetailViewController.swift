//
//  ItemsDetailViewController.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/09/25.
//

import UIKit

final class ItemsDetailViewController: UIViewController, AutoInjectable {
    
    // MARK: Enums
    enum Action {
        case close
    }
    
    // MARK: Private Properties
    private let resolver: AppResolver
    private let viewModel: ItemsDetailViewModel
    private let itemsDetailView: ItemsDetailView
    private var dismissLoadingView: WindowLoadingView.DismissTrigger?
    
    // MARK: LifeCycle
    init(viewModel: ItemsDetailViewModel, resolver: AppResolver) {
        self.viewModel = viewModel
        self.itemsDetailView = ItemsDetailView(viewModel: viewModel)
        self.resolver = resolver
        
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) { nil }
    
    override func loadView() {
        view = itemsDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
}

// MARK: Setup
private extension ItemsDetailViewController {
    
    func setup() {
        setupItemsDetailView()
    }
    
    func setupItemsDetailView() {
        itemsDetailView.perform = { [weak self] action in
            
            guard let self = self else { return }
            
            self.perform(action: action)
        }
    }
}

// MARK: Actions
private extension ItemsDetailViewController {
    
    func perform(action: Action) {
        
        switch action {
        case .close:
            self.dismiss(animated: true)
        }
    }
}
