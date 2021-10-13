//
//  MovesDetailViewController.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/10/09.
//

import UIKit

final class MovesDetailViewController: UIViewController, AutoInjectable {
    
    // MARK: Enums
    enum Action {
        case close
    }
    
    // MARK: Private Properties
    private let resolver: AppResolver
    private let viewModel: MovesDetailViewModel
    private let movesDetailView: MovesDetailView
    private var dismissLoadingView: WindowLoadingView.DismissTrigger?
    
    // MARK: LifeCycle
    init(viewModel: MovesDetailViewModel, resolver: AppResolver) {
        self.viewModel = viewModel
        self.movesDetailView = MovesDetailView(viewModel: viewModel)
        self.resolver = resolver
        
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) { nil }
    
    override func loadView() {
        view = movesDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
}

// MARK: Setup
private extension MovesDetailViewController {
    
    func setup() {
        setupMovesDetailView()
    }
    
    func setupMovesDetailView() {
        movesDetailView.perform = { [weak self] action in
            
            guard let self = self else { return }
            
            self.perform(action: action)
        }
    }
}

// MARK: Action
private extension MovesDetailViewController {
    
    func perform(action: Action) {
        switch action {
        case .close:
            self.dismiss(animated: true)
        }
    }
}
