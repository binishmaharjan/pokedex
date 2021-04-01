//
//  LoadingView.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/01/05.
//

import UIKit

final class LoadingView: UIView, XibInstantiable {
    
    typealias IndicatorStyle = (style: UIActivityIndicatorView.Style, color: UIColor?)
    
    enum Parent {
        /// UIWindow に add する場合
        case window
        /// UIView に add する場合
        case view
        
        var backgroundColor: UIColor {
            switch self {
            case .view:
                return UIColor.gray
            case .window:
                return UIColor.black.withAlphaComponent(0.3)
            }
        }
        
        var textColor: UIColor {
            switch self {
            case .view:
                return .darkGray
            case .window:
                return .white
            }
        }
        
        var indicatorStyle: IndicatorStyle {
            switch self {
            case .view:
                return IndicatorStyle(.large, .gray)
            case .window:
                return IndicatorStyle(.large, .white)
            }
        }
        
        var label: String {
            switch self {
            case .view:
                return "Loading"
            case .window:
                return "Loading"
            }
        }
    }
    
    @IBOutlet private weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet private weak var label: UILabel!
    @IBOutlet private var backgroundView: UIView!
    
    private var parent: Parent = .view {
        didSet {
            setupViews()
        }
    }

    
    init(parent: Parent) {
        self.parent = parent
        
        super.init(frame: .zero)
        
        let _view = UINib(nibName: Self.className, bundle: nil)
            .instantiate(withOwner: self, options: nil).first as! UIView
        
        _view.frame = bounds
        addSubview(_view)
        _view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        setupViews()
        start()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

private extension LoadingView {
    
    func setupViews() {
        backgroundView.backgroundColor = parent.backgroundColor
        
        label.text = parent.label
        label.textColor = parent.textColor
        label.font = .systemFont(ofSize: 12)
        
        indicatorView.style = parent.indicatorStyle.style
        indicatorView.color = parent.indicatorStyle.color
    }
    
    func start() {
        indicatorView.startAnimating()
    }
}
