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
        typeImageView.image = UIImage.from(viewModel.targetType)
        
        var weakness: Double = 0.0
        if let primaryType = viewModel.primaryType {
            weakness += (primaryType.weakness[viewModel.targetType] ?? 0.0)
        }
        
        if let secondaryType = viewModel.secondaryType {
            weakness *= (secondaryType.weakness[viewModel.targetType] ?? 0.0)
        }
        
        if weakness < 0.25 && weakness != 0 {
            weakness = 0.25
        }
        
        if weakness > 4.0 {
            weakness = 4.0
        }
        
        weaknessLabel.text = "\(weakness.description)x"
    }
}

struct WeaknessCellViewModel {
    var targetType: Type
    var primaryType: Type?
    var secondaryType: Type?
}
