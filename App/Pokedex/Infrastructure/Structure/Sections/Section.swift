//
//  Section.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/04/02.
//

import Foundation

struct Section<Model, Element> {
    
    let model: Model
    let elements: [Element]
    
    init(model: Model, elements: [Element]) {
        self.model = model
        self.elements = elements
    }
    
    init(model: Model, _ elements: Element...) {
        self.model = model
        self.elements = elements
    }
    
    subscript(_ index: Int) -> Element {
        elements[index]
    }
    
    subscript(_ index: Int) -> Element? {
        elements.indices.contains(index) ? elements[index] : nil
    }
    
    var numberOfRows: Int {
        elements.count
    }
}

extension Section: Equatable where Model: Equatable, Element: Equatable { }
extension Section: Hashable where Model: Hashable, Element: Hashable { }
