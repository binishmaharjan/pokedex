//
//  SearchField.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/01/17.
//

import UIKit
import ReactiveSwift

final class SearchField: UIView {
    
    @IBOutlet private weak var searchTextField: UITextField!
    @IBOutlet private weak var searchArea: UIView!
    @IBOutlet private weak var gradientView: UIView!
    
    private let  mutableSearchedText: MutableProperty<String> = MutableProperty("")
    var searchedText: Property<String> { Property(mutableSearchedText) }

    override init(frame: CGRect) {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        let _view = UINib(nibName: Self.className, bundle: nil)
            .instantiate(withOwner: self, options: nil).first as! UIView
        
        _view.frame = bounds
        addSubview(_view)
        _view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        searchArea.layer.cornerRadius = 20
        searchArea.layer.masksToBounds = true
        
        gradientView.applyGradient()
        
        mutableSearchedText <~ searchTextField.reactive.continuousTextValues

    }
}
