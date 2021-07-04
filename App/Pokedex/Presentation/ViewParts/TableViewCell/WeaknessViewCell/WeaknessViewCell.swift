//
//  WeaknessViewCell.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/07/04.
//

import UIKit

final class WeaknessViewCell: UICollectionViewCell {

    @IBOutlet private weak var typeImageView: UIImageView!
    @IBOutlet private weak var weaknessLabel: UILabel!
    
    func bind(viewModel: WeaknessCellViewModel) {
        
    }
}

struct WeaknessCellViewModel {
    var targetType: Type
    var primaryType: Type
    var secondaryType: Type?
}
