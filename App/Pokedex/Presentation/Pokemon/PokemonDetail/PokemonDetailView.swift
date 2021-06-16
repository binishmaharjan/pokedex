//
//  PokemonDetailView.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/04/14.
//

import UIKit

final class PokemonDetailView: UIView {
    
    // MARK: IBOutlet
    @IBOutlet private weak var backgroundView: UIView!
    @IBOutlet private weak var titleView: UIView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet private weak var closeButton: UIButton!
    @IBOutlet private weak var titleNameLabelView: UILabel!
    
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
        // Do Something
    }
}

// MARK: Bind
private extension PokemonDetailView {
    
    func bind() {
        viewModel.displayType.producer.skipNil().startWithValues { [weak self] typeName in
            guard let self = self else { return }
            
            self.backgroundView.applyGradient(with: typeName)
        }
    }
}
