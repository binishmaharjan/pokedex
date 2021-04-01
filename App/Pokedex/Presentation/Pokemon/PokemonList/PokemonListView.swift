//
//  PokemonListView.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/03/31.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa

final class PokemonListView: UIView {
    
    @IBOutlet private weak var overlayView: UIView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet weak var searchField: SearchField!
    
    private let viewModel: PokemonListViewModel
    private var sections: PokemonListSections = .empty {
        didSet {
            tableView.reloadData()
        }
    }
    
    init(viewModel: PokemonListViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        
        loadOwnedXib()
        setup()
        bind()
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    func bind() {
        reactive[\.sections] <~ viewModel.sections
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
        sections.numberOfSections()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections.numberOfRow(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(of: PokemonListCell.self, for: indexPath)
        let cellViewModel = PokemonListCellViewModel(pokemon: sections[indexPath])
        
        cell.bind(viewModel: cellViewModel)

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
