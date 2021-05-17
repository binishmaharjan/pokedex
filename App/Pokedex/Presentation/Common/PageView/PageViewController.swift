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
