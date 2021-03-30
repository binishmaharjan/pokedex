//
//  PokemonListViewController.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/03/31.
//

import UIKit

final class PokemonListViewController: UIViewController, AutoInjectable {
    
    private let pokemonListView: PokemonListView
    
    init() {
        self.pokemonListView = PokemonListView()
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
        addBehaviors([TransparentNavigationBarBehaviour()])
        title = "Pokemon"
    }
}
