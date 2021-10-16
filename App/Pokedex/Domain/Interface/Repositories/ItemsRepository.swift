//
//  ItemsRepository.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/09/14.
//

import Foundation

protocol ItemsRepository {
    
    @discardableResult
    func fetchItemsList(offset: Int, limit: Int, _ handler: @escaping(Result<[ListItem], APIError>) -> Void) -> Cancellable?
    
    @discardableResult
    func fetchItemsInfoList(requestValue: ClosedRange<Int>, _ handler: @escaping(Result<[PriceItemsListItem], APIError>) -> Void) -> Cancellable?
    
    @discardableResult
    func fetchMasterItemsData(id: Int, _ handler: @escaping(Result<Items, APIError>) -> Void) -> Cancellable?
}
