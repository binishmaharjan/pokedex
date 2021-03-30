//
//  PokemonListCell.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/01/08.
//

import UIKit
import ReactiveSwift

class PokemonListCell: UITableViewCell {
    
    @IBOutlet private weak var pokemonImageView: UIImageView!
    @IBOutlet private weak var pokemonNameLabel: UILabel!
    @IBOutlet private weak var pokemonIdLabel: UILabel!
    @IBOutlet private weak var typeOneImageView: UIImageView!
    @IBOutlet private weak var typeTwoImageView: UIImageView!
}
