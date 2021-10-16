//
//  DefaultMovesRepository.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/07/24.
//

import Foundation
import ReactiveSwift
import ReactiveCocoa

final class DefaultMovesRepository: MovesRepository, AutoInjectable {
    
    // MARK: Properties
    private let apiClient: APIClient
    
    // MARK: Moves Typed List Properties
    private let dispatchGroup = DispatchGroup()
    private var movesList: [TypeMovesListItem] = []
    private var error: APIError?
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func fetchList(offset: Int, limit: Int, _ handler: @escaping(Result<[ListItem], APIError>) -> Void) -> Cancellable? {
        
        let request = MovesListRequest(offset: offset, limit: limit)
        
        let task = apiClient.send(request) { result in
            switch result {
            case .success(let responseDTO):
                let movesList = responseDTO.toDomain()
                handler(.success(movesList.results))
                
            case .failure(let error):
                handler(.failure(error))
            }
        }
        
        return task
    }
    
    func fetchMovesInfoList(requestValue: ClosedRange<Int>, _ handler: @escaping (Result<[TypeMovesListItem], APIError>) -> Void) -> Cancellable? {
        
        error = nil
        movesList.removeAll()
        
        requestValue.forEach { id in
            dispatchGroup.enter()
            
            let request = MovesRequest(id: id)
            
            let _ = apiClient.send(request) { [weak self] result in
                
                guard let self = self else { return }
                
                switch result {
                case .success(let info):
                    let typeItem = TypeMovesListItem.from(movesInfo: info.toDomain())
                    self.movesList.append(typeItem)
                    
                case .failure(let error):
                    self.error = error
                }
                
                self.dispatchGroup.leave()
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            
            guard let self = self else { return }
            
            self.dispatchGroup.notify(queue: .main) {
                if let error = self.error {
                    handler(.failure(error))
                } else {
                    let sortedList = self.movesList.sorted()
                    handler(.success(sortedList))
                }
            }
        }
        
        return nil
    }
    
    func fetchMasterMoveData(id: Int, _ handler: @escaping (Result<Moves, APIError>) -> Void) -> Cancellable? {
        
        let moveRequest = MovesRequest(id: id)
        
        let task = apiClient.send(moveRequest) { result in
            switch result {
            case .success(let responseDTO):
                let move = responseDTO.toDomain()
                handler(.success(move))
                
            case .failure(let error):
                handler(.failure(error))
            }
        }
        
        return task
    }
}
