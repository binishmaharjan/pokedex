//
//  MovesListState.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/07/26.
//

import Foundation

struct MovesListState {
    
    // MARK: Private Properties
    private var movesFullList: [ListItem] = []
    private var currentMovesList: [TypeMovesListItem] = []
    
    // MARK: Paging Related
    let initialOffset: Int = 0
    let fetchLimit: Int = 50
    var currentPage: Int = 0
    var totalPageCount: Int = 1
    var hasMorePage: Bool { return currentPage < totalPageCount }
    var nextPage: Int { hasMorePage ? (currentPage + 1) : currentPage }
    
    // MARK: Public Properties
    var movesList: LoadingState<[TypeMovesListItem], APIError> = .initial
    var searchText: String = ""
    
    var sections: MovesListSections {
        switch movesList {
        case .completed(.success(let list)):
            return .from(list)
        case .loading(nextPage: true):
            return .from(currentMovesList)
        case .initial, .loading(nextPage: false), .completed(.failure):
            return .empty
        }
    }
    
    var searchedMovesList: [ListItem] {
        guard !(searchText.isEmpty) else {
            return movesFullList
        }
        
        return movesFullList.filter { $0.name.contains(searchText) }
    }
    
    mutating func addMovesFullList(_ list: [ListItem]) {
        movesFullList = list
    }
    
    mutating func initialMoves(_ list: [TypeMovesListItem]) {
        currentMovesList = list
        movesList = .completed(.success(currentMovesList))
    }
    
    mutating func appendMoves(_ list: [TypeMovesListItem]) {
        currentMovesList.append(contentsOf: list)
        movesList = .completed(.success(currentMovesList))
    }
}

// MARK: Sections
typealias MovesListSections = Sections<String, TypeMovesListItem>

extension MovesListSections {
    
    static func from(_ moves: [TypeMovesListItem]) -> MovesListSections {
        let sections = MovesListSections(
            sections:[
                Section(
                    model: "Moves",
                    elements: moves
                )
            ]
        )
        
        return sections
    }
}
