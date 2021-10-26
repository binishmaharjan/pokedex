//
//  BaseViewModel.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/10/18.
//

import Foundation
import ReactiveSwift
import ReactiveCocoa

final class ListViewModel: AutoInjectable {
    
    // MARK: Enums
    enum ListItemType: Equatable {
        case pokemon(PokemonListObject)
        case items(ItemsListObject)
        case moves(MovesListObject)
    }
    
    // MARK: Private Properties
    @Observable
    private var state = ListState()
    private let fullListUseCase: ListUseCase
    private let pokemonListUseCase: PokemonListUseCase
    private let itemsListUseCase: ItemsListUseCase
    private let movesListUseCase: MovesListUseCase
    
    // MARK: Public Properties
    let listType: ListUseCase.ListType
    
    var loadingState: Property<AnyLoadingState> {
        $state
            .map(\.list)
            .map(AnyLoadingState.init)
            .skipRepeats()
    }
    
    var sections: Property<ListSections> {
        $state
            .map(\.sections)
            .skipRepeats()
    }
    
    var searchedList: Property<[ListObject]> {
        $state
            .map(\.searchedList)
            .skipRepeats()
    }
    
    var startIndex: Int {
        (state.currentPage * state.fetchLimit) + 1
    }
    
    var endIndex: Int {
        (state.currentPage + 1) * state.fetchLimit
    }
    
    // MARK: Init
    init(listType: ListUseCase.ListType, fullListUseCase: ListUseCase, pokemonListUseCase: PokemonListUseCase, itemsListUseCase: ItemsListUseCase, movesListUseCase: MovesListUseCase) {
        self.listType = listType
        self.fullListUseCase = fullListUseCase
        self.pokemonListUseCase = pokemonListUseCase
        self.itemsListUseCase = itemsListUseCase
        self.movesListUseCase = movesListUseCase
    }
}

// MARK: API
extension ListViewModel {
    
    func fetchFullList() {
        state.list = .loading(nextPage: false)
        state.currentPage = 0
        state.totalPageCount = 1
        
        fullListUseCase.execute(listType: listType) { [weak self] result  in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let list):
                self.state.totalPageCount = list.count % self.state.fetchLimit == 0 ?
                    (list.count / self.state.fetchLimit) :
                    (list.count / self.state.fetchLimit) + 1
                
                self.state.addFullList(list)
                self.fetchList()
                
            case .failure(let error):
                self.state.list = .completed(.failure(error))
            }
        }
    }
    
    func fetchList() {
        switch listType {
        case .pokemon:
            fetchPokemonList()
        case .items:
            fetchItemsList()
        case .moves:
            fetchMovesList()
        }
    }
    
    func fetchNextList() {
        guard state.hasMorePage else { return }
        state.list = .loading(nextPage: true)
        
        switch listType {
        case .pokemon:
            fetchNextPokemonList()
        case .items:
            fetchNextItemsList()
        case .moves:
            fetchNextMovesList()
        }
    }
    
    private func fetchPokemonList() {
        let requestValue = PokemonListUseCase.RequestValue(range: startIndex...endIndex)
        
        pokemonListUseCase.execute(requestValue: requestValue) { [weak self] result in
            
            guard let self = self else { return }
            switch result {
            case .success(let list):
                self.state.currentPage += 1
                self.state.initialList(
                    list.map { ListItemType.pokemon($0) }
                )
                
            case .failure(let error):
                self.state.list = .completed(.failure(error))
            }
        }
    }
    
    private func fetchNextPokemonList() {
        let requestValue = PokemonListUseCase.RequestValue(range: startIndex...endIndex)
        
        pokemonListUseCase.execute(requestValue: requestValue) { [weak self] result in
            
            guard let self = self else { return }
            switch result {
            case .success(let list):
                self.state.currentPage += 1
                self.state.appendList(
                    list.map { ListItemType.pokemon($0) }
                )
                
            case .failure(let error):
                self.state.list = .completed(.failure(error))
            }
        }
    }
    
    private func fetchItemsList() {
        let requestValue = ItemsListUseCase.RequestValue(range: startIndex ... endIndex)
        
        itemsListUseCase.execute(requestValue: requestValue) { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let list):
                self.state.currentPage += 1
                self.state.initialList(
                    list.map { ListItemType.items($0) }
                )
                
            case .failure(let error):
                self.state.list = .completed(.failure(error))
            }
        }
    }
    
    private func fetchNextItemsList() {
        let requestValue = ItemsListUseCase.RequestValue(range: startIndex...endIndex)
        
        itemsListUseCase.execute(requestValue: requestValue) { [weak self] result in
        
            guard let self = self else { return }
            
            switch result {
            case .success(let list):
                
                self.state.currentPage += 1
                self.state.initialList(
                    list.map { ListItemType.items($0) }
                )
                
            case .failure(let error):
                self.state.list = .completed(.failure(error))
            }
        }
    }
    
    private func fetchMovesList() {
        let requestValue = MovesListUseCase.RequestValue(range: startIndex...endIndex)
        
        movesListUseCase.execute(requestValue: requestValue) { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let list):
                
                self.state.currentPage += 1
                
                self.state.initialList(
                    list.map { ListItemType.moves($0) }
                )
                
            case .failure(let error):
                self.state.list = .completed(.failure(error))
            }
        }
    }
    
    private func fetchNextMovesList() {
        let requestValue = MovesListUseCase.RequestValue(range: startIndex...endIndex)
        
        movesListUseCase.execute(requestValue: requestValue) { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let list):
                
                self.state.currentPage += 1
                
                self.state.appendList(
                    list.map { ListItemType.moves($0) }
                )
                
            case .failure(let error):
                self.state.list = .completed(.failure(error))
            }
        }
    }
}

// MARK: Filter
extension ListViewModel {
    
    func filter(with text: String) {
        state.searchText = text
    }
}

// MARK: State
struct ListState {
    
    // MARK: Private Properties
    private var fullList: [ListObject] = []
    private var currentList: [ListViewModel.ListItemType] = []
    
    // MARK: Paging Related
    let initialOffset: Int = 0
    let fetchLimit: Int = 50
    var currentPage: Int = 0
    var totalPageCount: Int = 1
    var hasMorePage: Bool { return currentPage < totalPageCount }
    var nextPage: Int { hasMorePage ? (currentPage + 1) : currentPage }
    
    // MARK: Public Properties
    var list: LoadingState<[ListViewModel.ListItemType], APIError> = .initial
    var searchText: String = ""
    
    var sections: ListSections {
        switch list {
        case .completed(.success(let list)):
            return .from(list)
        case .loading(nextPage: true):
            return .from(currentList)
        default:
            return .empty
        }
    }
    
    var searchedList: [ListObject] {
        guard searchText.isEmpty == false else {
            return fullList
        }
        
        return fullList.filter { $0.name.contains(searchText) }
    }
    
    // MARK: Mutating Methods
    mutating func addFullList(_ list: [ListObject]) {
        fullList = list
    }
    
    mutating func initialList(_ list: [ListViewModel.ListItemType]) {
        currentList = list
        self.list = .completed(.success(currentList))
    }
    
    mutating func appendList(_ list: [ListViewModel.ListItemType]) {
        currentList.append(contentsOf: list)
        self.list = .completed(.success(currentList))
    }
}


// MARK: Sections
typealias ListSections = Sections<String, ListViewModel.ListItemType>
extension ListSections {
    
    static func from(_ list: [ListViewModel.ListItemType]) -> ListSections {
        let sections = ListSections(
            sections: [
                Section(
                    model: "List",
                    elements: list
                )
            ]
        )
        
        return sections
    }
}
