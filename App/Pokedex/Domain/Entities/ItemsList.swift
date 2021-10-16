//
//  ItemsList.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/09/14.
//

import Foundation

struct PriceItemList: Equatable {
    let items: [PriceItemsListItem]
}

struct PriceItemsListItem: Equatable, Comparable {
    let name: String
    let id: Int
    let price: Int
    
    static func from(itemInfo: Items) -> PriceItemsListItem {
        PriceItemsListItem(name: itemInfo.name, id: itemInfo.id, price: itemInfo.price)
    }
    
    static func < (lhs: PriceItemsListItem, rhs: PriceItemsListItem) -> Bool {
        lhs.id < rhs.id
    }
}
