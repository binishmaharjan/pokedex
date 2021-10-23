//
//  MovesDetailUseCase.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/10/09.
//

import Foundation

final class MovesDetailUseCase: AutoInjectable {
    
    private let movesRepository: MovesRepository
    
    init(movesRepository: MovesRepository) {
        self.movesRepository = movesRepository
    }
    
    @discardableResult
    func execute(id: Int, _ handler: @escaping(Result<Moves, APIError>) -> Void) -> Cancellable? {
        return movesRepository.fetchMasterMoveData(id: id, handler)
    }
}
