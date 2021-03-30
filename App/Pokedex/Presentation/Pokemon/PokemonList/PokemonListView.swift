//
//  PokemonListView.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/03/31.
//

import UIKit

final class PokemonListView: UIView {
    
    @IBOutlet private weak var overlayView: UIView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet weak var searchField: SearchField!
    
    init() {
        super.init(frame: .zero)
        
        loadOwnedXib()
        setup()
    }
    
    required init?(coder: NSCoder) {
        nil
    }
}

// MARK: Setup
extension PokemonListView {
    
    private func setup() {
        setupBackground()
        setupTableView()
    }
    
    private func setupBackground() {
        overlayView.addBlur()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerXib(of: PokemonListCell.self)
        tableView.tableFooterView = UIView()
    }
}

// MARK: TableViewDataSource
extension PokemonListView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(of: PokemonListCell.self, for: indexPath)

        return cell
    }
}

// MARK: TableViewDelegate
extension PokemonListView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
