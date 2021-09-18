//
//  ItemsListCellViewModel.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/09/18.
//

import Foundation
import ReactiveSwift

struct ItemsListCellViewModel: AutoInjectable {
    
    private let item: PriceItemsListItem
    
    let name: Property<String>
    let id: Property<Int>
    let price: Property<String>
    let imageUrl: Property<URL>
    
    init(item: PriceItemsListItem) {
        self.item = item
        self.name = Property(value: item.name.capitalized)
        self.id = Property(value: item.id)
        self.price = Property(value: item.price.description)
        self.imageUrl = Property(value: ApplicationConfiguration.current.spriteUrl(appending: "/items/\(item.name).png"))
    }
}
