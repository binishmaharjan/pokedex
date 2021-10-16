//
//  ItemsRepository.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/09/14.
//

import Foundation

protocol ItemsRepository: ListRepository {
    
    @discardableResult
    func fetchItemsInfoList(requestValue: ClosedRange<Int>, _ handler: @escaping(Result<[PriceItemsListItem], APIError>) -> Void) -> Cancellable?
    
    @discardableResult
    func fetchMasterItemsData(id: Int, _ handler: @escaping(Result<Items, APIError>) -> Void) -> Cancellable?
}
