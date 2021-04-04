//
//  SearchResultView.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/04/04.
//

import UIKit

protocol SearchResult {
    var name: String { get set }
}

final class SearchResultView<Elements: SearchResult>: UIView, UITableViewDataSource, UITableViewDelegate  {
    
    @IBOutlet private weak var tableView: UITableView!
    private var elements: [Elements]
    
    var onSelect: (Elements) -> Void
    
    init(elements: [Elements], onSelect: @escaping (Elements) -> Void) {
        self.elements = elements
        self.onSelect = onSelect
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    // MARK: TableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    // MARK: TableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
