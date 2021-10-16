//
//  MovesList.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/07/23.
//

import Foundation

//struct MovesList {
//    let count: Int
//    let moves: [MovesListItem]
//}
//
//struct MovesListItem: Equatable, Searchable {
//    
//    var id: Int {
//        guard let lastString = url.split(separator: "/").last, let id = Int(lastString) else {
//            return 0
//        }
//        
//        return id
//    }
//    
//    var name: String
//    var url: String
//}

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
