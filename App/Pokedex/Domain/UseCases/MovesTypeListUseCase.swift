//
//  MovesTypeListUseCase.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/07/26.
//

import Foundation

final class MovesTypeListUseCase: AutoInjectable {
    
    struct RequestValue {
        let range: ClosedRange<Int>
    }
    
    private let movesRepository: MovesRepository
    
    init(movesRepository: MovesRepository) {
        self.movesRepository = movesRepository
    }
    
    @discardableResult
    func execute(requestValue: RequestValue, _ handler: @escaping(Result<[TypeMovesListItem], APIError>) -> Void) -> Cancellable? {
        
        return movesRepository.fetchMovesInfoList(requestValue: requestValue.range, handler)
    }
}
