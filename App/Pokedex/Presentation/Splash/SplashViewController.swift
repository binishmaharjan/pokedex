//
//  SplashViewController.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/03/28.
//

import UIKit

final class SplashViewController: SingleContainerViewContainer, AutoInjectable {
    
    var onComplete: (() -> Void)?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        finishSplashView()
    }
}

private extension SplashViewController {
    
    func setupViews() {
        let storyboard = UIStoryboard(name: "SplashViewController", bundle: nil)
        guard let viewController = storyboard.instantiateInitialViewController() else { return }
        
        replace(viewController, animated: false)
    }
    
    func finishSplashView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            self?.onComplete?()
        }
    }
}
