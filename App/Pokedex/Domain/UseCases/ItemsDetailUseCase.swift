//
//  ItemsDetailUseCase.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/09/25.
//

import Foundation

final class ItemDetailUseCase: AutoInjectable {
    
    private let itemsRepository: ItemsRepository
    
    init(itemsRepository: ItemsRepository) {
        self.itemsRepository = itemsRepository
    }
    
    @discardableResult
    func execute(id: Int, _ handler: @escaping(Result<Items, APIError>) -> Void) -> Cancellable? {
        return itemsRepository.fetchMasterItemsData(id: id, handler)
    }
}
