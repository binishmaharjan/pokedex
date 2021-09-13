//
//  ItemsFullListUseCase.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/09/14.
//

import Foundation

final class ItemsListUseCase: AutoInjectable {
    
    struct RequestValue {
        let offset = 0
        let limit = 954
    }
    
    private let itemsRepository: ItemsRepository
    
    init(itemsRepository: ItemsRepository) {
        self.itemsRepository = itemsRepository
    }
    
    @discardableResult
    func execute(_ handler: @escaping (Result<[ItemsListItem], APIError>) -> Void) -> Cancellable? {
        let requestValue = RequestValue()
        
        return itemsRepository.fetchItemsList(offset: requestValue.offset, limit: requestValue.limit, handler)
    }
}
