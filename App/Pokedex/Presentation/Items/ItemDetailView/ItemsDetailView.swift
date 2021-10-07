//
//  ItemsDetailView.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/09/25.
//

import UIKit
import ReactiveSwift

final class ItemsDetailView: UIView {
    
    // MARK: IBOutlet
    @IBOutlet private weak var backgroundView: UIView!
    
    @IBOutlet private weak var titleView: UIView!
    @IBOutlet private weak var closeButton: UIButton!
    @IBOutlet private weak var titleNameLabelView: UILabel!
    
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var informationViewArea: UIView!
    @IBOutlet private weak var informationStackView: UIStackView!
    @IBOutlet private weak var informationScrollView: UIScrollView!
    
    @IBOutlet private weak var itemImageIcon: UIImageView!
    @IBOutlet private weak var itemNameLabel: UILabel!
    @IBOutlet private weak var itemDescriptionLabel: UILabel!
    
    @IBOutlet weak var itemEffectLabel: UILabel!
    @IBOutlet private weak var itemPriceLabel: UILabel!
    
    // MARK: Private Properties
    private let viewModel: ItemsDetailViewModel
    
    // MARK: Public Properties
    var perform: ((ItemsDetailViewController.Action) -> Void)?
    
    // MARK: LifeCycle
    required init?(coder: NSCoder) { nil }
    init(viewModel: ItemsDetailViewModel) {
        self.viewModel = viewModel
        
        super.init(frame: .zero)
        
        loadOwnedXib()
        
        setup()
        
        bind()
        
        viewModel.fetchItemsDetail()
    }
    
    // MARK: IBOutlets
    @IBAction func closeButtonPressed(_ sender: Any) {
        perform?(.close)
    }
}

// MARK: Setup
private extension ItemsDetailView {
    
    func setup() {
        informationViewArea.layer.cornerRadius = 24
        
        backgroundView.applyGradient(for: .type(.water))
        
        setupPriceLabel()

        setupSwipeGesture()
    }
    
    func setupPriceLabel() {
        itemPriceLabel.layer.cornerRadius = 20
        itemPriceLabel.clipsToBounds = true
    }
    
    func setupSwipeGesture() {
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeft))
        swipeLeftGesture.direction = .left
        addGestureRecognizer(swipeLeftGesture)
        
        let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeRight))
        swipeRightGesture.direction = .right
        addGestureRecognizer(swipeRightGesture)
    }
    
    @objc private func swipeLeft() {
        viewModel.currentIndex = viewModel.currentIndex + 1
        informationScrollView.setContentOffset(.zero, animated: false)
        viewModel.fetchItemsDetail()
    }
    
    @objc private func swipeRight() {
        viewModel.currentIndex = viewModel.currentIndex - 1
        informationScrollView.setContentOffset(.zero, animated: false)
        viewModel.fetchItemsDetail()
    }
}

// MARK: Bind
private extension ItemsDetailView {
    
    func bind() {
        
        informationStackView.reactive.isHidden <~ viewModel.loadingState.map(\.isHiddenSuccess)
        
        itemNameLabel.reactive.text <~ viewModel.masterItemData.skipNil().map(\.name.capitalized)
        itemDescriptionLabel.reactive.text <~ viewModel.flavoredTextEntry.skipNil()
        itemEffectLabel.reactive.text <~ viewModel.effectText.skipNil()
        
        titleNameLabelView.reactive.text <~ viewModel.masterItemData.skipNil().map(\.name.capitalized)
        
        itemPriceLabel.reactive.text <~ viewModel.masterItemData.skipNil().map(\.price).map { "\($0)₽" }
        
        viewModel.imageUrl.skipNil().startWithValues { [weak self] url in
            guard let self = self else { return }
            
            self.itemImageIcon.loadImage(at: url)
        }
    }
}
