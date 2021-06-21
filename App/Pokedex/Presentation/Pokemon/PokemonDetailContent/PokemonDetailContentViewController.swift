//
//  PokemonDetailContentViewController.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/04/20.
//

import UIKit

final class PokemonDetailContentViewController: UIViewController, AutoInjectable {
    
    // MARK: Private Properties
    private let viewModel: PokemonDetailContentViewModel
    private let pokemonDetailContentView: PokemonDetailContentView
    
    // MARK: Public Properties
    var currentIndex: Int { viewModel.currentIndex }
    var changeBackground: ((Type) -> Void)?
    
    // MARK: LifeCycle
    init(viewModel: PokemonDetailContentViewModel) {
        self.viewModel = viewModel
        self.pokemonDetailContentView = PokemonDetailContentView(viewModel: viewModel)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    override func loadView() {
        view = pokemonDetailContentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        bind()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.fetchPokemonDetail()
    }
    
    func bind() {
        viewModel.typeOne.producer.startWithValues { [weak self] (type) in
            guard let self = self else { return }
            
            self.changeBackground?(type)
        }
    }
}
