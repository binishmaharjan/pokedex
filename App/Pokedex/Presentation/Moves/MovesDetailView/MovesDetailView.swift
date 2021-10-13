//
//  MovesDetailView.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/10/09.
//

import UIKit
import ReactiveSwift

final class MovesDetailView: UIView {
    
    // MARK: IBOutlet
    @IBOutlet private weak var backgroundView: UIView!
    
    @IBOutlet private weak var titleView: UIView!
    @IBOutlet private weak var closeButton: UIButton!
    @IBOutlet private weak var titleNameLabelView: UILabel!
    
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var informationViewArea: UIView!
    @IBOutlet private weak var informationStackView: UIStackView!
    @IBOutlet private weak var informationScrollView: UIScrollView!
    
    @IBOutlet private weak var movesImageIcon: UIImageView!
    @IBOutlet private weak var movesNameLabel: UILabel!
    @IBOutlet private weak var movesDescriptionLabel: UILabel!
    @IBOutlet private weak var movesDescriptionTitleLabel: UILabel!
    
    @IBOutlet private weak var typeImageView: UIImageView!
    
    // MARK: Private Properties
    private let viewModel: MovesDetailViewModel
    
    // MARK: Public Properties
    var perform: ((MovesDetailViewController.Action) -> Void)?
    
    // MARK: LifeCycle
    required init?(coder: NSCoder) { nil }
    init(viewModel: MovesDetailViewModel) {
        self.viewModel = viewModel
        
        super.init(frame: .zero)
        
        loadOwnedXib()
        
        setup()
        
        bind()
        
        viewModel.fetchMovesDetail()
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        perform?(.close)
    }
}

// MARK: Setup
private extension MovesDetailView {
    
    func setup() {
        informationViewArea.layer.cornerRadius = 24
        setupSwipeGesture()
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
        viewModel.fetchMovesDetail()
    }
    
    @objc private func swipeRight() {
        viewModel.currentIndex = viewModel.currentIndex - 1
        informationScrollView.setContentOffset(.zero, animated: false)
        viewModel.fetchMovesDetail()
    }
}

// MARK: Bind
private extension MovesDetailView {
    
    func bind() {
        
        viewModel.type.startWithValues { [weak self] type in
            guard let self = self else { return }
            self.backgroundView.applyGradient(with: type)
        }
        
        informationStackView.reactive.isHidden <~ viewModel.loadingState.map(\.isHiddenSuccess)
        
        titleNameLabelView.reactive.text <~ viewModel.masterMovesData.skipNil().map(\.name.capitalized)
        movesNameLabel.reactive.text <~ viewModel.masterMovesData.skipNil().map(\.name.capitalized)
        movesDescriptionLabel.reactive.text <~ viewModel.masterMovesData.skipNil().map(\.description)
        movesDescriptionTitleLabel.reactive.textColor <~ viewModel.type.map { UIColor.primaryColor(for: $0) ?? .c4F4F4F }
        movesImageIcon.reactive.image <~ viewModel.masterMovesData.skipNil().map { UIImage.from($0.type.name) }
        
        typeImageView.reactive.image <~ viewModel.masterMovesData.skipNil().map { UIImage.from($0.type.name, imageType: .tag) }
    }
}
