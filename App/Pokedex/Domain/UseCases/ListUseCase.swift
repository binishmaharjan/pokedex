//
//  ListUseCase.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/10/16.
//

import Foundation

/// Common List UseCase For Fetching Full List
final class ListUseCase: AutoInjectable {
    
    enum ListType {
        case pokemon
        case items
        case moves
        
        var max: Int {
            switch self {
            case .pokemon: return 1118
            case .items: return 954
            case .moves: return 844
            }
        }
        
        var title: String {
            switch self {
            case .pokemon: return "Pokemon"
            case .items: return "Items"
            case .moves: return "Moves"
            }
        }
    }
    
    struct RequestValue {
        let offset, limit: Int
    }
    
    private let listRepository: ListRepository
    
    init(listRepository: ListRepository) {
        self.listRepository = listRepository
    }
    
    @discardableResult
    func execute(listType: ListType, _ handler: @escaping (Result<[ListObject], APIError>) -> Void) -> Cancellable? {
        let requestValue = ListUseCase.requestValue(for: listType)
        return listRepository.fetchList(offset: requestValue.offset, limit: requestValue.limit, handler)
    }
}

extension ListUseCase {
    
    static func requestValue(for listType: ListType) -> RequestValue {
        RequestValue(offset: 0, limit: listType.max)
    }
}
