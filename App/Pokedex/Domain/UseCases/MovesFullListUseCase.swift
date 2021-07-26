//
//  MovesFullListUseCase.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/07/26.
//

import Foundation

final class MovesFullListUseCase: AutoInjectable {
    
    struct RequestValue {
        let offset = 0
        let limit = 844
    }
    
    private let movesRepository: MovesRepository
    
    init(movesRepository: MovesRepository) {
        self.movesRepository = movesRepository
    }
    
    @discardableResult
    func execute(_ handler: @escaping (Result<[MovesListItem], APIError>) -> Void) -> Cancellable? {
        let requestValue = RequestValue()
        
        return movesRepository.fetchMovesList(offset: requestValue.limit, limit: requestValue.limit, handler)
    }
}
