//
//  MultiContainerViewController.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2020/12/31.
//

import UIKit

final class MultiContainerViewController: UIViewController {
    
    private let contentViewControllers: [UIViewController]
    
    var selectedIndex = 0 {
        willSet { removeContent(currentContentViewController) }
        didSet { addContent(currentContentViewController) }
    }
    
    init(_ contentViewControllers: UIViewController...) {
        self.contentViewControllers = contentViewControllers
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addContent(currentContentViewController)
    }
}

private extension MultiContainerViewController {
    
    var currentContentViewController: UIViewController {
        contentViewControllers[selectedIndex]
    }
    
    func addContent(_ viewController: UIViewController) {
        addChild(viewController)
        view.addSubview(viewController.view)
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.view.frame = view.bounds
        viewController.didMove(toParent: self)
    }
    
    func removeContent(_ viewController: UIViewController) {
        guard viewController.parent == self else { return }
        
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }
}
