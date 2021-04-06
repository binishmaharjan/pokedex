//
//  SearchField.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/01/17.
//

import UIKit
import ReactiveSwift

final class SearchField: UIView {
    
    enum EditingStatus {
        case beginEditing
        case endEditing
    }
    
    @IBOutlet private weak var searchTextField: UITextField!
    @IBOutlet private weak var searchArea: UIView!
    @IBOutlet private weak var gradientView: UIView!
    @IBOutlet private weak var closeButton: UIButton!
    
    private let  mutableSearchedText: MutableProperty<String> = MutableProperty("")
    var searchedText: Property<String> { Property(mutableSearchedText) }
    
    var onEditingStatusChanged: ((EditingStatus) -> Void)?
    
    var delegate: UITextFieldDelegate? {
        get { searchTextField.delegate }
        set { searchTextField.delegate = newValue }
    }

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
        
        searchArea.layer.cornerRadius = 20
        searchArea.layer.masksToBounds = true
        
        searchTextField.delegate = self
        
        closeButton.isHidden = true
        
        gradientView.applyGradient()
        
        mutableSearchedText <~ searchTextField.reactive.continuousTextValues
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        searchTextField.text = ""
        searchTextField.resignFirstResponder()
    }
}

extension SearchField: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        closeButton.isHidden = false
        onEditingStatusChanged?(.beginEditing)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        closeButton.isHidden = true
        onEditingStatusChanged?(.endEditing)
    }
}
