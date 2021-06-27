//
//  PokemonDetailView.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/04/14.
//

import UIKit
import ReactiveSwift

final class PokemonDetailView: UIView {
    
    // MARK: IBOutlet
    @IBOutlet private weak var backgroundView: UIView!
    
    @IBOutlet private weak var titleView: UIView!
    @IBOutlet private weak var closeButton: UIButton!
    @IBOutlet private weak var titleNameLabelView: UILabel!
    
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var informationViewArea: UIView!
    @IBOutlet private weak var pokemonImageIcon: UIImageView!
    @IBOutlet private weak var pokemonNameLabel: UILabel!
    @IBOutlet private weak var pokemonTypeOneImageView: UIImageView!
    @IBOutlet private weak var pokemonTypeTwoImageView: UIImageView!
    @IBOutlet private weak var pokemonDescriptionLabel: UILabel!
    
    // MARK: Private Properties
    private let viewModel: PokemonDetailViewModel
    
    // MARK: Public Properties
    var perform: ((PokemonDetailViewController.Action) -> Void)?
    
    // MARK: LifeCycle
    init(viewModel: PokemonDetailViewModel) {
        self.viewModel = viewModel
        
        super.init(frame: .zero)
        
        loadOwnedXib()
        
        setup()
        
        bind()
        
        viewModel.fetchPokemonDetail()
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    // MARK: IBOutlets
    @IBAction func closeButtonPressed(_ sender: Any) {
        perform?(.close)
    }
}

// MARK: Setup
private extension PokemonDetailView {
    
    func setup() {
        informationViewArea.layer.cornerRadius = 36
        
        // Hide type two image at the start
        pokemonTypeTwoImageView.isHidden = true
    }
}

// MARK: Bind
private extension PokemonDetailView {
    
    func bind() {
        viewModel.type.producer.skipNil().startWithValues { [weak self] type in
            guard let self = self else { return }
            
            self.backgroundView.applyGradient(with: type)
        }
        
        pokemonNameLabel.reactive.text <~ viewModel.masterPokemonData.skipNil().map(\.name.capitalized)
        pokemonDescriptionLabel.reactive.text <~ viewModel.flavoredTextEntry
        titleNameLabelView.reactive.text <~ viewModel.masterPokemonData.skipNil().map(\.name.capitalized)
        
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
