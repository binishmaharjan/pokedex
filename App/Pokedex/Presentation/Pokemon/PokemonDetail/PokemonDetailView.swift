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
    @IBOutlet private weak var pokemonStatsView: StatsView!
    @IBOutlet private weak var pokemonWeaknessView: WeaknessView!
    
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
        informationViewArea.layer.cornerRadius = 24
        
        // Hide type two image at the start
        pokemonTypeTwoImageView.isHidden = true
        
        setupStatsView()
        setupWeaknessView()
    }
    
    func setupStatsView() {
        pokemonStatsView.viewModel = viewModel
    }
    
    func setupWeaknessView() {
        pokemonWeaknessView.viewModel = viewModel
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
        
        pokemonTypeOneImageView.reactive.image <~ viewModel.typeOne.skipNil()
        pokemonTypeTwoImageView.reactive.image <~ viewModel.typeTwo.skipNil()
        pokemonTypeTwoImageView.reactive.isHidden <~ viewModel.hideSecondaryType.skipNil()
        
        viewModel.imageUrl.skipNil().startWithValues { [weak self] url in
            guard let self = self else { return }
            
            self.pokemonImageIcon.loadImage(at: url)
        }
    }
}
