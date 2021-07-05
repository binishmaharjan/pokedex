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
    
    // MARK: Private Properties
    private var weaknessCollectionView: UICollectionView?
    private var weaknessSections: WeaknessViewSections = .empty {
        didSet { weaknessCollectionView?.reloadData() }
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
extension WeaknessView {
    
    func setup() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        weaknessCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        weaknessCollectionView?.translatesAutoresizingMaskIntoConstraints = false
        weaknessCollectionView?.backgroundColor = .clear
        
        weaknessCollectionView?.registerXib(of: WeaknessViewCell.self)
        weaknessDetailView.addSubview(weaknessCollectionView!)
        
        NSLayoutConstraint.activate([
            weaknessCollectionView!.leadingAnchor.constraint(equalTo: weaknessDetailView.leadingAnchor),
            weaknessCollectionView!.trailingAnchor.constraint(equalTo: weaknessDetailView.trailingAnchor),
            weaknessCollectionView!.topAnchor.constraint(equalTo: weaknessDetailView.topAnchor),
            weaknessCollectionView!.bottomAnchor.constraint(equalTo: weaknessDetailView.bottomAnchor)
        ])
        
        weaknessCollectionView?.delegate = self
        weaknessCollectionView?.dataSource = self
    }
}

// MARK: Bind
extension WeaknessView {
    
    func bind() {
        weaknessTitleLabel.reactive.textColor <~ viewModel.primaryColor.skipNil()
        
        reactive[\.weaknessSections] <~ viewModel.weaknessSection
    }
}

// MARK: UICollectionViewDataSource
extension WeaknessView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        weaknessSections.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        weaknessSections.numberOfRow(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(of: WeaknessViewCell.self, for: indexPath)
        
        let targetType = weaknessSections[indexPath]
        let primaryType = viewModel.masterPokemonData.value?.primaryType
        let secondaryType = viewModel.masterPokemonData.value?.secondaryType
        
        cell.bind(viewModel: .init(targetType: targetType, primaryType: primaryType, secondaryType: secondaryType))
        
        return cell
    }
}

// MARK: UICollectionViewDelegate
extension WeaknessView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width / 3, height: collectionView.frame.height / 6)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}
