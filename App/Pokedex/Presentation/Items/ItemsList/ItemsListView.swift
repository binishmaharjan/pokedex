//
//  ItemListView.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/09/18.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa

final class ItemsListView: UIView {
    
    // MARK: IBOutlets
    @IBOutlet private weak var overlayView: UIView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet weak var searchField: SearchField!
    
    // MARK: Private Properties
    private let viewModel: ItemsListViewModel
    private var nextPageLoadingSpinner: UIActivityIndicatorView?
    private var searchResultView: SearchResultView<ItemsListItem>!
    private var searchResultHeightConstraints: NSLayoutConstraint?
    
    private var sections: ItemsListSections = .empty {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: Public Properties
    var onPerform: ((ItemsListViewController.Action) -> Void)?
    
    // MARK: Lifecycle
    required init?(coder: NSCoder) { nil }
    init(viewModel: ItemsListViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        
        loadOwnedXib()
        setup()
        bind()
    }
}

// MARK: Bind
extension ItemsListView {
    func bind() {
        reactive[\.sections] <~ viewModel.sections
        
        searchField.searchedText.signal.observeValues({ [weak self] searchText in
            
            guard let self = self else { return }
            self.viewModel.filter(with: searchText)
        })
    }
}

// MARK: Setup
extension ItemsListView {
    
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
        tableView.registerXib(of: ItemsListCell.self)
        tableView.tableFooterView = UIView()
    }
    
    private func setupSearchResultView() {
        // Initialize
        searchResultView = SearchResultView(elements: viewModel.searchedItemsList) { [weak self] element in
            
            guard let self = self else { return }
            
            
            self.onPerform?(.itemDetail(element.id))
        }
        
        // Text Field Status
        searchField.onEditingStatusChanged = { [weak self] status in
            
            guard let self = self else { return }
            
            self.searchResultHeightConstraints?.isActive = status == .beginEditing
            
            UIView.animate(withDuration: 0.1) { [weak self] in
                guard let self = self else { return }
                self.layoutIfNeeded()
            }
        }
        
        // Constraints
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

// MARK: TableViewDataSource
extension ItemsListView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections.numberOfRow(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(of: ItemsListCell.self, for: indexPath)
        let cellViewModel = ItemsListCellViewModel(item: sections[indexPath])
        cell.bind(viewModel: cellViewModel)
        
        if indexPath.row == sections.numberOfRow(in: indexPath.section) - 1 {
            viewModel.fetchNextItemsList()
        }
        
        return cell
    }
}

// MARK: TableViewDelegate
extension ItemsListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = sections[indexPath]
        
        onPerform?(.itemDetail(item.id))
    }
}
