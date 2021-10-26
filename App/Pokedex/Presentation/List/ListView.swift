//
//  ListView.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/10/23.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa

final class ListView: UIView {
    
    // MARK: IBOutlets
    @IBOutlet private weak var overlayView: UIView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet weak var searchField: SearchField!
    
    // MARK: Private Properties
    private let viewModel: ListViewModel
    private var nextPageLoadingSpinner: UIActivityIndicatorView?
    private var searchResultView: SearchResultView<ListObject>!
    private var searchResultHeightConstraints: NSLayoutConstraint?
    
    private var sections: ListSections = .empty {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: Public Properties
    var onPerform: ((ListViewController.Action) -> Void)?
    
    // MARK: Lifecycle
    required init?(coder: NSCoder) { nil }
    init(viewModel: ListViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        
        loadOwnedXib()
        
        setup()
        bind()
    }
}

//  MARK: Setup
extension ListView {
    
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
        searchResultView = SearchResultView(elements: viewModel.searchedList) { [weak self] element in
            
            guard let self = self else { return }
            self.onPerform?(.pokemonDetail(element.id, nil))
        }
        
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
    
    /// Show Indicator for Paging
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

// MARK: Bind
extension ListView {
    
    private func bind() {
        reactive[\.sections] <~ viewModel.sections
        
        searchField.searchedText.signal.observeValues { [weak self] searchedText in
            guard let self = self else { return }
            self.viewModel.filter(with: searchedText)
        }
    }
}

// MARK: TableView DataSource
extension ListView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections.numberOfRow(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch  sections[indexPath] {
        case .pokemon(let pokemonObject):
            let cell = tableView.dequeueCell(of: PokemonListCell.self, for: indexPath)
            let cellViewModel = PokemonListCellViewModel(pokemon: pokemonObject)
            cell.bind(viewModel: cellViewModel)
            
            //Uncomment this for paging
            if indexPath.row == sections.numberOfRow(in: indexPath.section) - 1 {
                viewModel.fetchNextList()
            }
            
            return cell
        default:
            fatalError()
        }
    }
}

// MARK: TableView Delegate
extension ListView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch sections[indexPath] {
        case .pokemon(let pokemonObject):
            onPerform?(.pokemonDetail(pokemonObject.id, pokemonObject.elements[0].type.name))
        default:
            fatalError()
        }
    }
}
