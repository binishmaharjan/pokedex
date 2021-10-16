//
//  DefaultItemsRepository.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/09/14.
//

import Foundation
import ReactiveSwift
import ReactiveCocoa

final class DefaultItemsRepository: ItemsRepository, AutoInjectable {
    
    // MARK: Properties
    private let apiClient: APIClient
    
    // MARK: Moves Typed List Properties
    private let dispatchGroup = DispatchGroup()
    private var itemsList: [PriceItemsListItem] = []
    private var error: APIError?
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func fetchList(offset: Int, limit: Int, _ handler: @escaping(Result<[ListItem], APIError>) -> Void) -> Cancellable? {
        
        let request = ItemsListRequest(offset: offset, limit: limit)
        
        let task = apiClient.send(request) { result in
            switch result {
            case .success(let responseDTO):
                let itemsList = responseDTO.toDomain()
                handler(.success(itemsList.results))
                
            case .failure(let error):
                handler(.failure(error))
            }
        }
        return task
    }
    
    func fetchItemsInfoList(requestValue: ClosedRange<Int>, _ handler: @escaping (Result<[PriceItemsListItem], APIError>) -> Void) -> Cancellable? {
        
        error = nil
        itemsList.removeAll()
        
        requestValue.forEach { id in
            dispatchGroup.enter()
            
            let request = ItemsRequest(id: id)
            
            let _ = apiClient.send(request) { [weak self] result in
                
                guard let self = self else { return }
                
                switch result {
                case .success(let info):
                    let priceItem = PriceItemsListItem.from(itemInfo: info.toDomain())
                    self.itemsList.append(priceItem)
                    
                case .failure(let error):
                    self.error = error
                }
                
                self.dispatchGroup.leave()
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            [weak self] in
            
            guard let self = self else { return }
            
            self.dispatchGroup.notify(queue: .main) {
                if let error = self.error {
                    handler(.failure(error))
                } else {
                    let sortedList = self.itemsList.sorted()
                    handler(.success(sortedList))
                }
            }
        }
        
        return nil
    }
    
    func fetchMasterItemsData(id: Int, _ handler: @escaping (Result<Items, APIError>) -> Void) -> Cancellable? {
        let itemsRequest = ItemsRequest(id: id)
        
        let task = apiClient.send(itemsRequest) { result in
            switch result {
            case .success(let responseDTO):
                let item = responseDTO.toDomain()
                handler(.success(item))
                
            case .failure(let error):
                handler(.failure(error))
            }
        }
        
        return task
    }
}
