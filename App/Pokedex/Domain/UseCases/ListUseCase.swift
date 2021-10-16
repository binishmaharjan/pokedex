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
        
        var max: Int {
            switch self {
            case .pokemon: return 1118
            case .items: return 954
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
    func execute(listType: ListType, _ handler: @escaping (Result<[ListItem], APIError>) -> Void) -> Cancellable? {
        let requestValue = ListUseCase.requestValue(for: listType)
        return listRepository.fetchList(offset: requestValue.offset, limit: requestValue.limit, handler)
    }
}

extension ListUseCase {
    
    static func requestValue(for listType: ListType) -> RequestValue {
        RequestValue(offset: 0, limit: listType.max)
    }
}
