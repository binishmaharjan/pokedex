//
//  ItemsListUseCase.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/09/14.
//

import Foundation

final class ItemsListUseCase: AutoInjectable {
    
    struct RequestValue {
        let range: ClosedRange<Int>
    }
    
    private let itemsRepository: ItemsRepository
    
    init(itemsRepository: ItemsRepository) {
        self.itemsRepository = itemsRepository
    }
    
    @discardableResult
    func execute(requestValue: RequestValue, _ handler: @escaping(Result<[ItemsListObject], APIError>) -> Void) -> Cancellable? {
        return itemsRepository.fetchItemsList(requestValue: requestValue.range, handler)
    }
}
