//
//  ListRepository.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/10/16.
//

import Foundation

protocol ListRepository {
    
    @discardableResult
    func fetchList(offset: Int, limit: Int, _ handler: @escaping(Result<[ListObject], APIError>) -> Void) -> Cancellable?
}
