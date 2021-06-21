//
//  PokemonDetailContainerView.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/04/21.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa

final class PokemonDetailContentView: UIView {
    
    // MARK: IBOutlets
    @IBOutlet private weak var informationViewArea: UIView!
    @IBOutlet private weak var pokemonImageIcon: UIImageView!
    @IBOutlet private weak var pokemonNameLabel: UILabel!
    @IBOutlet private weak var pokemonTypeOneImageView: UIImageView!
    @IBOutlet private weak var pokemonTypeTwoImageView: UIImageView!
    @IBOutlet private weak var pokemonDescriptionLabel: UILabel!
    
    // MARK: Public Properties
    
    
    // MARK: Private Properties
    private let viewModel: PokemonDetailContentViewModel
    
    // MARK: LifeCycle
    init(viewModel: PokemonDetailContentViewModel) {
        self.viewModel = viewModel
        
        super.init(frame: .zero)
        
        loadOwnedXib()
        
        setup()
        
        bind()
    }
    
    required init?(coder: NSCoder) {
        nil
    }
}

// MARK: Setup
private extension PokemonDetailContentView {
    
    func setup() {
        informationViewArea.layer.cornerRadius = 36
        
        // Hide type two image at the start
        pokemonTypeTwoImageView.isHidden = true
    }
}

// MARK: Bind
private extension PokemonDetailContentView {
    
    func bind() {
        pokemonNameLabel.reactive.text <~ viewModel.masterPokemonData.skipNil().map { $0.name.capitalized }
        pokemonDescriptionLabel.reactive.text <~ viewModel.flavoredTextEntry
        
        viewModel.imageUrl.skipNil().startWithValues { [weak self] url in
            guard let self = self else { return }
            
            self.pokemonImageIcon.loadImage(at: url)
        }
        
        viewModel.typeOne.startWithValues { [weak self] type in
            guard let self = self else { return }
                
            self.pokemonTypeOneImageView.image = .from(type, imageType: .tag)
        }
        
        viewModel.typeTwo.startWithValues { [weak self] type in
            guard let self = self else { return }
                
            // Unhide the type two since its exists
            self.pokemonTypeTwoImageView.isHidden = false
            self.pokemonTypeTwoImageView.image = .from(type, imageType: .tag)
        }
    }
}
