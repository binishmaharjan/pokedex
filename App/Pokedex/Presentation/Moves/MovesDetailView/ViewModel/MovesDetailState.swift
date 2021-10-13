//
//  MovesDetailState.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/10/09.
//

import Foundation

struct MovesDetailState {
    
    var backgroundType: Type?
    var masterMoveData: LoadingState<Moves, APIError> = .initial
    
    var masterMoves: Moves? {
        switch masterMoveData {
        case .completed(.success(let masterData)):
            return masterData
        default:
            return nil
        }
    }
}
