//
//  PokemonDetailContainerView.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/04/21.
//

import UIKit

final class PokemonDetailContentView: UIView {
    
    // MARK: Public Properties
    @IBOutlet private weak var idLabel: UILabel!
    
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
        idLabel.text = viewModel.currentIndex.description
    }
}

// MARK: Bind
private extension PokemonDetailContentView {
    
}
