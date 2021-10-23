//
//  ItemsListState.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/09/14.
//

import Foundation

struct ItemsListState {
    
    // MARK: Private Properties
    private var itemsFullList: [ListObject] = []
    private var currentItemsList: [ItemsListObject] = []
    
    // MARK: Paging Related
    let initialOffset: Int = 0
    let fetchLimit: Int = 50
    var currentPage: Int = 0
    var totalPageCount: Int = 1
    var hasMorePage: Bool { return currentPage < totalPageCount }
    var nextPage: Int { hasMorePage ? (currentPage + 1) : currentPage }
    
    // MARK: Public Properties
    var itemsList: LoadingState<[ItemsListObject], APIError> = .initial
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
    
    var searchItemsList: [ListObject] {
        guard !(searchText.isEmpty) else {
            return itemsFullList
        }
        
        return itemsFullList.filter {
            $0.name.contains(searchText)
        }
    }
    
    mutating func addItemsFullList(_ list: [ListObject]) {
        itemsFullList = list
    }
    
    mutating func initialItems(_ list: [ItemsListObject]) {
        currentItemsList = list
        itemsList = .completed(.success(currentItemsList))
    }
    
    mutating func appendItems(_ list: [ItemsListObject]) {
        currentItemsList.append(contentsOf: list)
        itemsList = .completed(.success(currentItemsList))
    }
}

// MARK: Sections
typealias ItemsListSections = Sections<String, ItemsListObject>

extension ItemsListSections {
    
    static func from(items: [ItemsListObject]) -> ItemsListSections {
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
