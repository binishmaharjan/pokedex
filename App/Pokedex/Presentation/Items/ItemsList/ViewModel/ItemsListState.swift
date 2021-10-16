//
//  ItemsListState.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/09/14.
//

import Foundation

struct ItemsListState {
    
    // MARK: Private Properties
    private var itemsFullList: [ListItem] = []
    private var currentItemsList: [PriceItemsListItem] = []
    
    // MARK: Paging Related
    let initialOffset: Int = 0
    let fetchLimit: Int = 50
    var currentPage: Int = 0
    var totalPageCount: Int = 1
    var hasMorePage: Bool { return currentPage < totalPageCount }
    var nextPage: Int { hasMorePage ? (currentPage + 1) : currentPage }
    
    // MARK: Public Properties
    var itemsList: LoadingState<[PriceItemsListItem], APIError> = .initial
    var searchText: String = ""
    
    var sections: ItemsListSections {
        switch itemsList {
        case .completed(.success(let list)):
            return .from(items: list)
        case .loading(nextPage: true):
            return .from(items: currentItemsList)
        case .initial, .loading(nextPage: false), .completed(.failure):
            return .empty
        }
    }
    
    var searchItemsList: [ListItem] {
        guard !(searchText.isEmpty) else {
            return itemsFullList
        }
        
        return itemsFullList.filter {
            $0.name.contains(searchText)
        }
    }
    
    mutating func addItemsFullList(_ list: [ListItem]) {
        itemsFullList = list
    }
    
    mutating func initialItems(_ list: [PriceItemsListItem]) {
        currentItemsList = list
        itemsList = .completed(.success(currentItemsList))
    }
    
    mutating func appendItems(_ list: [PriceItemsListItem]) {
        currentItemsList.append(contentsOf: list)
        itemsList = .completed(.success(currentItemsList))
    }
}

// MARK: Sections
typealias ItemsListSections = Sections<String, PriceItemsListItem>

extension ItemsListSections {
    
    static func from(items: [PriceItemsListItem]) -> ItemsListSections {
        let sections = ItemsListSections(
            sections: [
                Section(
                    model: "Items",
                    elements: items
                )
            ]
        )
        return sections
    }
}
