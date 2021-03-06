//
//  MovesListViewModel.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/07/23.
//

import Foundation
import ReactiveSwift

final class MovesListViewModel: AutoInjectable {
    
    @Observable
    private var state = MovesListState()
    private let movesFullListUseCase: MovesFullListUseCase
    private let movesTypeListUseCase: MovesTypeListUseCase

    init(movesListUseCase: MovesTypeListUseCase, movesFullListUseCase: MovesFullListUseCase) {
        self.movesFullListUseCase = movesFullListUseCase
        self.movesTypeListUseCase = movesListUseCase
    }
    
    var loadingState: Property<AnyLoadingState> {
        $state
            .map(\.movesList)
            .map(AnyLoadingState.init)
            .skipRepeats()
    }
    
    var sections: Property<MovesListSections> {
        $state
            .map(\.sections)
            .skipRepeats()
    }
    
    var searchedMovesList: Property<[MovesListItem]> {
        $state
            .map(\.searchedMovesList)
            .skipRepeats()
    }
}

// MARK: API
extension MovesListViewModel {
    
    func fetchMovesFullList() {
        state.movesList = .loading(nextPage: false)
        state.currentPage = 0
        state.totalPageCount = 1
        
        movesFullListUseCase.execute { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let list):
                self.state.totalPageCount = list.count % self.state.fetchLimit == 0 ?
                    (list.count / self.state.fetchLimit) :
                    (list.count / self.state.fetchLimit) + 1
                
                self.state.addMovesFullList(list)
                
                self.fetchMovesFullList()
                
            case .failure(let error):
                self.state.movesList = .completed(.failure(error))
            }
        }
    }
    
    func fetchMovesList() {
        let startIndex = (state.currentPage * state.fetchLimit) + 1
        let endIndex = (state.currentPage + 1) * state.fetchLimit
        
        let requestValue = MovesTypeListUseCase.RequestValue(range: startIndex...endIndex)
        
        movesTypeListUseCase.execute(requestValue: requestValue) { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let moveList):
                
                self.state.currentPage += 1
                
                self.state.initialMoves(moveList)
                
            case .failure(let error):
                self.state.movesList = .completed(.failure(error))
            }
        }
    }
    
    func fetchNextMovesList() {
        guard state.hasMorePage else { return }
        
        state.movesList = .loading(nextPage: true)
        
        let startIndex = (state.currentPage * state.fetchLimit) + 1
        let endIndex = (state.currentPage + 1) * state.fetchLimit
        
        let requestValue = MovesTypeListUseCase.RequestValue(range: startIndex...endIndex)
        
        movesTypeListUseCase.execute(requestValue: requestValue) { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let movesList):
                self.state.currentPage += 1
                
                self.state.appendMoves(movesList)
                
            case .failure(let error):
                self.state.movesList = .completed(.failure(error))
            }
        }
    }
}

// MARK: Filter
extension MovesListViewModel {
    
    func filter(with text: String) {
        state.searchText = text
    }
}
