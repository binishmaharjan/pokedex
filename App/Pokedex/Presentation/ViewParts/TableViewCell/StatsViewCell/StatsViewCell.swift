//
//  StatsViewCell.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/06/29.
//

import UIKit

class StatsViewCell: UITableViewCell {
    
    // MARK: IBOutlet
    @IBOutlet private weak var statsTitleLabel: UILabel!
    @IBOutlet private weak var statsAmountLabel: UILabel!
    @IBOutlet private weak var statsGraphBaseView: UIView!
    
    @IBOutlet private weak var statsGraphView: UIView!
    @IBOutlet weak var statsGraphViewWidthConstraints: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setup()
    }
}

// MARK: Setup
private extension StatsViewCell {
    
    func setup() {
        
        statsGraphView.layer.cornerRadius = 4
        statsGraphBaseView.layer.cornerRadius = 4
    }
}

// MARK: Bind
extension StatsViewCell {
    
    func bind(viewModel: StatsCellViewModel) {
        
        statsTitleLabel.text = viewModel.stats.stat.name.displayText
        statsAmountLabel.text = viewModel.stats.baseStat.description
        
        // Set Stats Graph
        let statsRatio = CGFloat(viewModel.stats.baseStat) / 100
        statsGraphViewWidthConstraints = statsGraphViewWidthConstraints.setMultiplier(multiplier: min(statsRatio, 1.0))
        
        statsGraphView.backgroundColor = .primaryColor(for: viewModel.type)
        statsTitleLabel.textColor = .primaryColor(for: viewModel.type)
    }
}

struct StatsCellViewModel {
    
    let stats: Stats
    let type: Type
    
    init(type: Type, stats: Stats) {
        self.stats = stats
        self.type = type
    }
}
