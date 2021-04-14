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
    private let viewModel: PokemonDetailViewModel
    private let pokemonDetailView: PokemonDetailView
    private var dismissLoading: WindowLoadingView.DismissTrigger?
    
    // MARK: LifeCycle
    init(viewModel: PokemonDetailViewModel) {
        self.viewModel = PokemonDetailViewModel()
        self.pokemonDetailView = PokemonDetailView(viewModel: viewModel)
        
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
        
    }
}

// MARK: Bind
private extension PokemonDetailViewController {
    
    func bind() {
        
    }
}
