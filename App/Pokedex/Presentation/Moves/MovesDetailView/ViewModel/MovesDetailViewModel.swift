//
//  MovesDetailViewModel.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/10/09.
//

import Foundation
import ReactiveSwift
import ReactiveCocoa

final class MovesDetailViewModel: AutoInjectable {
    
    // MARK: Private Properties
    @Observable
    private var state = MovesDetailState()
    private let movesDetailUseCase: MovesDetailUseCase
    
    private var cancellable: Cancellable?
    
    // MARK: Public Properties
    var currentIndex: Int
    
    init(currentIndex: Int, backgroundType: Type?, movesDetailUseCase: MovesDetailUseCase) {
        self.currentIndex = currentIndex
        self.movesDetailUseCase = movesDetailUseCase
        self.state.backgroundType = backgroundType
    }
}

// MARK: Computed Properties
extension MovesDetailViewModel {
    
    var loadingState: Property<AnyLoadingState> {
        $state
            .map(\.masterMoveData)
            .map(AnyLoadingState.init)
            .skipRepeats()
    }
    
    var masterMovesData: Property<Moves?> {
        $state
            .map(\.masterMoves)
    }
    
    var type: SignalProducer<Type, Never> {
        SignalProducer.merge(
            $state.map(\.backgroundType).skipNil().take(first: 1),
            $state.map(\.masterMoves?.type.name).skipNil()
        )
    }
}

// MARK: API
extension MovesDetailViewModel {
    
    func fetchMovesDetail() {
        cancellable?.cancel()
        
        state.masterMoveData = .loading(nextPage: false)
        
        cancellable = movesDetailUseCase.execute(id: currentIndex) { [weak self] result in
            
            guard let self = self else { return }
            
            self.state.masterMoveData = .completed(result)
        }
    }
}
