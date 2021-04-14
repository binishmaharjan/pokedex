//
//  PokemonDetailView.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/04/14.
//

import UIKit

final class PokemonDetailView: UIView {
    
    // MARK: IBOutlet
    
    // MARK: Public Properties
    private let viewModel: PokemonDetailViewModel
    
    // MARK: Private Properties
    
    // MARK: LifeCycle
    init(viewModel: PokemonDetailViewModel) {
        self.viewModel = viewModel
        
        super.init(frame: .zero)
        
        loadOwnedXib()
    }
    
    required init?(coder: NSCoder) {
        nil
    }
}

// MARK: Setup
private extension PokemonDetailView {
    
}

// MARK: Bind
private extension PokemonDetailView {
    
}
