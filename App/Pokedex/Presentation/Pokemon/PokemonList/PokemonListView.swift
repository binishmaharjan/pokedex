//
//  PokemonListView.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/01/06.
//

import UIKit
import ReactiveSwift

final class PokemonListView: UIView {

    @IBOutlet private weak var overlayView: UIView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet weak var searchField: SearchField!
    
    private let viewModel: PokemonListViewModel
    private var nextPageLoadingSpinner: UIActivityIndicatorView?
    private var searchResultView: SearchResultView<PokemonListItem>
    private var searchResultHeightConstraints: NSLayoutConstraint?
    
    private var sections: PokemonListSections = .empty {
        didSet { tableView.reloadData()
        }
    }
    
    init(viewModel: PokemonListViewModel) {
        self.viewModel = viewModel
        self.searchResultView = SearchResultView(elements: viewModel.searchedPokemonList, onSelect: { _ in })
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
        
        searchField.searchedText.signal.observeValues { [weak self] (searchedText) in
            guard let self = self else { return }
            self.viewModel.filter(with: searchedText)
        }
    }
}

// MARK: Setup
extension PokemonListView {
    
    private func setup() {
        setupBackground()
        setupTableView()
        setupSearchResultView()
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
    
    private func setupSearchResultView() {
        searchField.onEditingStatusChanged = { [weak self] status in
            
            guard let self = self else { return }
            
            self.searchResultHeightConstraints?.isActive = status == .beginEditing
            
            UIView.animate(withDuration: 0.1) { [weak self] in
                guard let self = self else { return }
                self.layoutIfNeeded()
            }
        }
        
        addSubview(searchResultView)
        searchResultView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchResultView.topAnchor.constraint(equalTo: tableView.topAnchor),
            searchResultView.leadingAnchor.constraint(equalTo: tableView.leadingAnchor),
            searchResultView.trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
        ])
        
        searchResultHeightConstraints = searchResultView.heightAnchor.constraint(equalTo: tableView.heightAnchor)
    }
    
    func showNextPageLoadingIndicator(isLoadingNextPage: Bool) {
        guard isLoadingNextPage else {
            tableView.tableFooterView = nil
            return
        }
        
        nextPageLoadingSpinner?.removeFromSuperview()
        nextPageLoadingSpinner = UIActivityIndicatorView(style: .medium)
        nextPageLoadingSpinner?.startAnimating()
        nextPageLoadingSpinner?.isHidden = false
        nextPageLoadingSpinner?.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.frame.width, height: 44)
        tableView.tableFooterView = nextPageLoadingSpinner
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
        
        
        //Uncomment this for paging
        if indexPath.row == sections.numberOfRow(in: indexPath.section) - 1 {
            viewModel.fetchNextPokemonList()
        }
        
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
