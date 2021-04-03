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
        
        viewModel.imageUrl.producer.startWithValues { [weak self] (url) in
            self?.pokemonImageView.loadImage(at: url)
        }
        
        viewModel.typeOne.producer.observe(on: UIScheduler())
            .startWithValues { [weak self] (type) in
                
            self?.typeOneImageView.image = .from(type)
        }
        
        viewModel.typeTwo.producer.observe(on: UIScheduler())
            .startWithValues { [weak self] (type) in
            self?.typeTwoImageView.image = .from(type)
        }
    }
}
