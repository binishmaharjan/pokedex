//
//  MovesRepository.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/07/24.
//

import Foundation

protocol MovesRepository: ListRepository {
    
    @discardableResult
    func fetchMovesInfoList(requestValue: ClosedRange<Int>, _ handler: @escaping(Result<[TypeMovesListItem], APIError>) -> Void) -> Cancellable?
    
    @discardableResult
    func fetchMasterMoveData(id: Int, _ handler: @escaping(Result<Moves, APIError>) -> Void) -> Cancellable?
}
