//
//  CaptureView.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/07/08.
//

import UIKit
import ReactiveSwift

final class CaptureView: UIView {
    
    // MARK: IBOutlet
    @IBOutlet private weak var captureTitleLabel: UILabel!
    
    @IBOutlet private weak var habitatTitleLabel: UILabel!
    @IBOutlet private weak var habitatLabel: UILabel!
    
    @IBOutlet private weak var generationTitleLabel: UILabel!
    @IBOutlet private weak var generationLabel: UILabel!
    
    @IBOutlet private weak var captureRateTitleLabel: UILabel!
    @IBOutlet private weak var captureRateLabel: UILabel!
    
    //  MARK: Public Properties
    var viewModel: PokemonDetailViewModel! {
        didSet {
            bind()
        }
    }
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        loadOwnedXib()
        
        setup()
    }
}

// MARK: Setup
extension CaptureView {
    
    func setup() { }
}

// MARK: Bind
extension CaptureView {
    
    func bind() {
        captureTitleLabel.reactive.textColor <~ viewModel.primaryColor.skipNil()
        habitatTitleLabel.reactive.textColor <~ viewModel.primaryColor.skipNil()
        generationTitleLabel.reactive.textColor <~ viewModel.primaryColor.skipNil()
        captureRateTitleLabel.reactive.textColor <~ viewModel.primaryColor.skipNil()
        
        habitatLabel.reactive.text <~ viewModel.masterPokemonData.skipNil().map(\.habitat.name.capitalized)
        generationLabel.reactive.text <~ viewModel.masterPokemonData.skipNil().map(\.generation.name.capitalized)
        captureRateLabel.reactive.text <~ viewModel.masterPokemonData.skipNil().map { "\($0.captureRate) %" }
    }
}
