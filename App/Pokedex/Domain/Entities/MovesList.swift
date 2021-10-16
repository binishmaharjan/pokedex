//
//  MovesList.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/07/23.
//

import Foundation

struct TypeMovesList: Equatable {
    
    let moves: [TypeMovesListItem]
}

struct TypeMovesListItem: Equatable, Comparable {
    let name: String
    let id: Int
    let type: TypeInfo
    
    static func from(movesInfo: Moves) -> TypeMovesListItem {
        TypeMovesListItem(name: movesInfo.name, id: movesInfo.id, type: movesInfo.type)
    }
    
    static func < (lhs: TypeMovesListItem, rhs: TypeMovesListItem) -> Bool {
        lhs.id < rhs.id
    }
}
