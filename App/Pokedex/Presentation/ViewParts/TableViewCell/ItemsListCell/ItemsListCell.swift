//
//  ItemsListCell.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/09/18.
//

import UIKit
import ReactiveSwift

class ItemsListCell: UITableViewCell {
    
    @IBOutlet private weak var itemImageView: UIImageView!
    @IBOutlet private weak var itemNameLabel: UILabel!
    @IBOutlet private weak var itemPriceLabel: UILabel!
    
    func bind(viewModel: ItemsListCellViewModel) {
        itemNameLabel.reactive.text <~ viewModel.name
        itemPriceLabel.reactive.text <~ viewModel.price
        
        viewModel.imageUrl
            .producer
            .startWithValues { [weak self] url in
                self?.itemImageView.loadImage(at: url)
            }
    }
}
