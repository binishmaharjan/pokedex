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
    
    private var sections: PokemonListSections = .empty {
        didSet { tableView.reloadData()
        }
    }
    
    init(viewModel: PokemonListViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        
        let _view = UINib(nibName: Self.className, bundle: nil)
            .instantiate(withOwner: self, options: nil).first as! UIView
        
        _view.frame = bounds
        addSubview(_view)
        _view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        setup()
        bind()
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    func bind() {
        reactive[\.sections] <~ viewModel.sections
        
//        searchField.searchedText.signal.observeValues { [weak self] (searchedText) in
//            self?.viewModel.filter(with: searchedText)
//        }
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

