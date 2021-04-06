//
//  SearchResultView.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/04/04.
//

import UIKit
import ReactiveSwift

protocol SearchResult {
    var name: String { get set }
}

final class SearchResultView<Elements: SearchResult>: UIView, UITableViewDataSource, UITableViewDelegate  {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var bottomConstraints: NSLayoutConstraint!
    
    private var elements: Property<[Elements]>
    
    var onSelect: (Elements) -> Void
    
    init(elements: Property<[Elements]>, onSelect: @escaping (Elements) -> Void) {
        self.elements = elements
        self.onSelect = onSelect
        super.init(frame: .zero)
        
        loadOwnedXib(xibName: "SearchResultView")
        
        setup()
        bind()
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    deinit {
        removeKeyboardObserver()
    }
    
    // MARK: Setup
    private func setup() {
        addKeyboardObservers()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func bind() {
        elements.producer.startWithValues { [weak self] (_) in
            guard let self = self else { return }
            
            self.tableView.reloadData()
        }
    }
    
    // MARK: TableView DataSource
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.value.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = elements.value[indexPath.row].name
        return cell
    }
    
    // MARK: TableView Delegate
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: On Keyboard Frame Changed
    @objc private func handleContentUnderKeyboard(notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardEndFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else  { return }
        
        switch notification.name {
        
        case UIResponder.keyboardWillHideNotification:
            moveContentForKeyboardDismissed()
            
        case UIResponder.keyboardWillShowNotification:
            moveContent(forKeyboardFrame: keyboardEndFrame.cgRectValue)
            
        default:
            break
        }
    }
}

// MARK: Keyboard Notifications
private extension SearchResultView {
    
    func addKeyboardObservers() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self,
                                       selector: #selector(handleContentUnderKeyboard(notification:)),
                                       name: UIResponder.keyboardWillHideNotification,
                                       object: nil)
        notificationCenter.addObserver(self,
                                       selector: #selector(handleContentUnderKeyboard(notification:)),
                                       name: UIResponder.keyboardWillShowNotification,
                                       object: nil)
    }
    
    func removeKeyboardObserver() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
    
    func moveContentForKeyboardDismissed() {
        bottomConstraints.constant = 0
    }
    
    func moveContent(forKeyboardFrame keyboardFrame: CGRect) {
        let keyboardHeight = keyboardFrame.height
        
        // Subtract 48, Since ViewController's tableview bottom anchor is set to safe area
        bottomConstraints.constant = -(keyboardHeight - 48)
    }
}
