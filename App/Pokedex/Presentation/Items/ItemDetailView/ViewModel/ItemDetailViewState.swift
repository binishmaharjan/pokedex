//
//  ItemDetailViewState.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/09/25.
//

import Foundation

struct ItemsDetailViewState {
    var masterItemState: LoadingState<Items, APIError> = .initial
    
    var masterItemData: Items? {
        switch masterItemState {
        case .completed(.success(let masterData)):
            return masterData
        default:
             return nil
        }
    }
    
    var imageUrl: URL? {
        switch masterItemState {
        case .completed(.success(let masterData)):
            let name = masterData.name
            return ApplicationConfiguration.current.spriteUrl(appending: "/items/\(name).png")
        default:
            return nil
        }
    }
}
