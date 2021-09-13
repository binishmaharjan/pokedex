//
//  MovesListCell.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/09/12.
//

import UIKit
import ReactiveSwift

class MovesListCell: UITableViewCell {

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var typeImageView: UIImageView!
    
    func bind(viewModel: MovesListCellViewModel) {
        nameLabel.reactive.text <~ viewModel.name
        
        typeImageView.reactive.image <~ viewModel.type.map { UIImage.from($0) }
    }
}
