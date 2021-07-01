//
//  StatsView.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/06/27.
//

import UIKit
import ReactiveSwift

final class StatsView: UIView {
    
    // MARK: IBOutlets
    @IBOutlet private weak var titleViewAreaView: UIView!
    @IBOutlet private weak var statsDetailBackground: UIView!
    @IBOutlet private weak var statsDetailView: UIView!
    @IBOutlet private weak var statsTableView: UITableView!
    
    // MARK: Private Properties
    private var statsSection: StatsViewSections = .empty {
        didSet { statsTableView.reloadData() }
    }
    
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
extension StatsView {
    
    func setup() {
        titleViewAreaView.roundCorners(corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: 12)
        statsDetailBackground.roundCorners(corners: [.layerMinXMaxYCorner, .layerMaxXMaxYCorner], radius: 12)
        statsDetailView.roundCorners(corners: [.layerMinXMaxYCorner, .layerMaxXMaxYCorner], radius: 6)
        
        statsTableView.registerXib(of: StatsViewCell.self)
        statsTableView.delegate = self
        statsTableView.dataSource = self
    }
}

// MARK: Bind
extension StatsView {
    
    func bind() {
        viewModel.type.producer.skipNil().startWithValues { [weak self] type in
            guard let self = self else { return }
            
            self.titleViewAreaView.applyGradient(with: type)
            self.statsDetailBackground.applyGradient(with: type)
        }
        
        reactive[\.statsSection] <~ viewModel.statsSections
    }
}

// MARK: UITableViewDataSource
extension StatsView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        statsSection.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        statsSection.numberOfRow(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(of: StatsViewCell.self, for: indexPath)
        cell.selectionStyle = .none
        
        let statsData = statsSection[indexPath]
        cell.bind(viewModel: StatsCellViewModel(type: statsData.type, stats: statsData.stats))
        
        return cell
    }
}

// MARK: UITableViewDelegate
extension StatsView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 25
    }
}
