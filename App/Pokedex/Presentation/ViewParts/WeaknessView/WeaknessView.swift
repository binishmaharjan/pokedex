//
//  WeaknessView.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/07/02.
//

import UIKit
import ReactiveSwift

final class WeaknessView: UIView {
    
    // MARK: IBOutlets
    @IBOutlet private weak var weaknessTitleLabel: UILabel!
    @IBOutlet private weak var titleViewAreaView: UIView!
    @IBOutlet private weak var weaknessDetailBackground: UIView!
    @IBOutlet private weak var weaknessDetailView: UIView!
    @IBOutlet private weak var weaknessCollectionView: UICollectionView!
    
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
extension WeaknessView {
    
    func setup() {
        titleViewAreaView.roundCorners(corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: 12)
        weaknessDetailBackground.roundCorners(corners: [.layerMinXMaxYCorner, .layerMaxXMaxYCorner], radius: 12)
        weaknessDetailView.roundCorners(corners: [.layerMinXMaxYCorner, .layerMaxXMaxYCorner], radius: 6)
    }
}

// MARK: Bind
extension WeaknessView {
    
    func bind() {
        weaknessTitleLabel.reactive.textColor <~ viewModel.primaryColor.skipNil()
    }
}