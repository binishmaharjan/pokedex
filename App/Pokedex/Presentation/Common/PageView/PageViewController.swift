//
//  PageViewController.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/04/18.
//

import UIKit

final class PageViewController: UIPageViewController {
    
    init() {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

final class TestViewController: UIViewController {
    
    let label: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "Label"
        return l
    }()
    
    let passedIndex: Int
    
    init(index: Int) {
        passedIndex = index
        
        super.init(nibName: nil, bundle: nil)
        
        label.text = index.description
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
