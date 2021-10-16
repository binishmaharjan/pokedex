//
//  MovesListCellViewModel.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/09/12.
//

import Foundation
import ReactiveSwift

struct MovesListCellViewModel: AutoInjectable {
    
    private let move: MovesListItem
    
    let name: Property<String>
    let id: Property<Int>
    let type: Property<Type>
    
    init(move: MovesListItem) {
        self.move = move
        
        self.name = Property(value: move.name.capitalized)
        self.id = Property(value: move.id)
        self.type = Property(value: move.element.name)
    }
}
