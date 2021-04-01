//
//  WindowLoadingView.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/04/02.
//

import UIKit

final class WindowLoadingView: UIWindow {
    
    private let loadingView = LoadingView(parent: .window)
    
    private static var view: WindowLoadingView?
    
    override init(windowScene: UIWindowScene) {
        super.init(windowScene: windowScene)
        setupViews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        nil
    }
}

extension WindowLoadingView {
    
    typealias DismissTrigger = () -> Void
    
    static func show() -> DismissTrigger {
        let windowScene = UIApplication.shared
            .connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .first
        view = WindowLoadingView(windowScene: windowScene as! UIWindowScene)
        view?.alpha = 0
        view?.windowLevel = .alert
        view?.makeKeyAndVisible()
        
        UIView.animate(withDuration: 0.1) {
            view?.alpha = 1
        }
        
        return {
            UIView.animate(
                withDuration: 0.2,
                animations: {
                    view?.alpha = 0
                },
                completion: { _ in
                    view = nil
                }
            )
        }
    }
}

private extension WindowLoadingView {
    
    func setupViews() {
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(loadingView)
        NSLayoutConstraint.activate([
            loadingView.topAnchor.constraint(equalTo: topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: leadingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: bottomAnchor),
            loadingView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        backgroundColor = .clear
    }
}

