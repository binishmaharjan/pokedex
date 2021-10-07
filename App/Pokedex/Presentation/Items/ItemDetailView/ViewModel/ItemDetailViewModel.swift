//
//  ItemDetailViewModel.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/09/25.
//

import Foundation
import ReactiveSwift
import ReactiveCocoa

final class ItemsDetailViewModel: AutoInjectable {
    
    // MARK: Private Properties
    @Observable
    private var state = ItemsDetailViewState()
    private let itemsDetailUseCase: ItemDetailUseCase
    
    private var cancellable: Cancellable?
    
    // MARK: Public Properties
    var currentIndex: Int
    
    init(currentIndex: Int, itemsDetailUseCase: ItemDetailUseCase) {
        self.currentIndex = currentIndex
        self.itemsDetailUseCase = itemsDetailUseCase
    }
}

// MARK: Computed Properties
extension ItemsDetailViewModel {
    
    var loadingState: Property<AnyLoadingState> {
        $state
            .map(\.masterItemState)
            .map(AnyLoadingState.init)
            .skipRepeats()
    }
    
    var masterItemData: Property<Items?> {
        $state
            .map(\.masterItemData)
    }
    
    var flavoredTextEntry: Property<String?> {
        $state
            .map(\.masterItemData?.flavorTextEntries.first?.text)
    }
    
    var effectText: Property<String?> {
        $state
            .map(\.masterItemData?.effectEntries.first?.effect)
    }
    
    var imageUrl: Property<URL?> {
        $state
            .map(\.imageUrl)
    }
}

// MARK: API
extension ItemsDetailViewModel {
    
    func fetchItemsDetail() {
        
        cancellable?.cancel()
        
        state.masterItemState = .loading(nextPage: false)
        
        cancellable = itemsDetailUseCase.execute(id: currentIndex) { [weak self] result in
            
            guard let self = self else { return }
            
            self.state.masterItemState = .completed(result)
        }
    }
}
