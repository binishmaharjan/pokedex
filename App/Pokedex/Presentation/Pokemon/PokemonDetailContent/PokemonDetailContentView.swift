//
//  PokemonDetailContainerView.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/04/21.
//

import UIKit

final class PokemonDetailContentView: UIView {
    
    // MARK: IBOutlets
    @IBOutlet weak var informationViewArea: UIView!
    @IBOutlet weak var pokemonImageIcon: UIImageView!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonTypeOneImageView: UIImageView!
    @IBOutlet weak var pokemonTypeTwoImageView: UIImageView!
    @IBOutlet weak var pokemonDescriptionLabel: UILabel!
    
    // MARK: Public Properties
    
    
    // MARK: Private Properties
    private let viewModel: PokemonDetailContentViewModel
    
    // MARK: LifeCycle
    init(viewModel: PokemonDetailContentViewModel) {
        self.viewModel = viewModel
        
        super.init(frame: .zero)
        
        loadOwnedXib()
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        nil
    }
}

// MARK: Setup
private extension PokemonDetailContentView {
    
    func setup() {
        setupBackground()
    }
    
    func setupBackground() {
        informationViewArea.layer.cornerRadius = 36
//        informationViewArea.roundCorners(corners: [.topLeft,.topRight], radius: 48)
    }
}

// MARK: Bind
private extension PokemonDetailContentView {
    
}
