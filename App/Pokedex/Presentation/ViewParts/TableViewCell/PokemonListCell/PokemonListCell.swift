//
//  PokemonListCell.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/01/08.
//

import UIKit
import ReactiveSwift

final class PokemonListCell: UITableViewCell {
    
    @IBOutlet private weak var pokemonImageView: UIImageView!
    @IBOutlet private weak var pokemonNameLabel: UILabel!
    @IBOutlet private weak var pokemonIdLabel: UILabel!
    @IBOutlet private weak var typeOneImageView: UIImageView!
    @IBOutlet private weak var typeTwoImageView: UIImageView!
    
    func bind(viewModel: PokemonListCellViewModel) {
        pokemonNameLabel.reactive.text <~ viewModel.name
        pokemonIdLabel.reactive.text <~ viewModel.id.map(\.stringId)
        typeOneImageView.reactive.image <~ viewModel.typeOne.map { UIImage.from($0) }
        typeTwoImageView.reactive.image <~ viewModel.typeTwo.map { UIImage.from($0) }
        
        viewModel.imageUrl
            .producer
            .startWithValues { [weak self] (url) in
                self?.pokemonImageView.loadImage(at: url)
            }
    }
}
