//
//  ItemsListViewModel.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/09/16.
//

import Foundation
import ReactiveSwift

final class ItemsListViewModel: AutoInjectable {

    @Observable
    private var state = ItemsListState()
    private let itemsFullListUseCase: ItemsListUseCase
    private let itemPriceListUseCase: ItemsPriceListUseCase
    
    init(itemsFullListUseCase: ItemsListUseCase, itemPriceListUseCase: ItemsPriceListUseCase) {
        self.itemsFullListUseCase = itemsFullListUseCase
        self.itemPriceListUseCase = itemPriceListUseCase
    }
    
    var loadingState: Property<AnyLoadingState> {
        $state
            .map(\.itemsList)
            .map(AnyLoadingState.init)
            .skipRepeats()
    }
    
    var sections: Property<ItemsListSections> {
        $state
            .map(\.sections)
            .skipRepeats()
    }
    
    var searchedItemsList: Property<[ItemsListItem]> {
        $state
            .map(\.searchItemsList)
            .skipRepeats()
    }
}

// MARK: API
extension ItemsListViewModel {
    
    func fetchItemFullList() {
        state.itemsList = .loading(nextPage: false)
        state.currentPage = 0
        state.totalPageCount = 1
        
        itemsFullListUseCase.execute { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let list):
                self.state.totalPageCount = list.count % self.state.fetchLimit == 0 ?
                    (list.count / self.state.fetchLimit) :
                    (list.count / self.state.fetchLimit) + 1
                
                self.state.addItemsFullList(list)
                
                self.fetchItemsList()
                
            case .failure(let error):
                self.state.itemsList = .completed(.failure(error))
            }
        }
    }
    
    func fetchItemsList() {
        let startIndex = (state.currentPage * state.fetchLimit) + 1
        let endIndex = (state.currentPage + 1) * state.fetchLimit
        
        let requestValue = ItemsPriceListUseCase.RequestValue(range: startIndex ... endIndex)
        
        itemPriceListUseCase.execute(requestValue: requestValue) { [weak self] result in
        
            guard let self = self else { return }
            
            switch result {
            case .success(let itemList):
                
                self.state.currentPage += 1
                self.state.initialItems(itemList)
                
            case .failure(let error):
                self.state.itemsList = .completed(.failure(error))
            }
        }
    }
    
    func fetchNextItemsList() {
        guard state.hasMorePage else { return }
        
        state.itemsList = .loading(nextPage: true)
        
        let startIndex = (state.currentPage * state.fetchLimit) + 1
        let endIndex = (state.currentPage + 1) * state.fetchLimit
        
        let requestValue = ItemsPriceListUseCase.RequestValue(range: startIndex...endIndex)
        
        itemPriceListUseCase.execute(requestValue: requestValue) { [weak self] result in
        
            guard let self = self else { return }
            
            switch result {
            case .success(let itemList):
                
                self.state.currentPage += 1
                self.state.appendItems(itemList)
                
            case .failure(let error):
                self.state.itemsList = .completed(.failure(error))
            }
        }
    }
}

extension ItemsListViewModel {
    
    func filter(with text: String) {
        state.searchText = text
    }
}
