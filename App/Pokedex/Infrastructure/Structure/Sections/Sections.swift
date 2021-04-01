//
//  Sections.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/04/02.
//

import Foundation

struct Sections<Model, Element> {
    
    private(set) var sections: [Section<Model, Element>]
    
    init(_ sections: Section<Model, Element>...) {
        self.sections = sections
    }
    
    init(sections: [Section<Model, Element>]) {
        self.sections = sections
    }
    
    mutating func appendSection(_ section: Section<Model, Element>) {
        sections.append(section)
    }
    
    subscript(_ indexPath: IndexPath) -> Element {
        sections[indexPath.section][indexPath.row]
    }
    
    subscript(optional indexPath: IndexPath) -> Element? {
        sections[indexPath.section][indexPath.row]
    }
    
    subscript(_ sectionIndex: Int) -> Model {
        sections[sectionIndex].model
    }
    
    func numberOfSections() -> Int {
        sections.count
    }
    
    func numberOfRow(in section: Int) -> Int {
        sections[section].numberOfRows
    }
    
    func allModels() -> [Model] {
        sections.map(\.model)
    }
    
    func allElements() -> [Element] {
        sections.flatMap(\.elements)
    }
    
    func filter(_ isIncluded: (Element) -> Bool) -> Sections<Model, Element> {
        let newSections = sections.map { section in
            Section(
                model: section.model,
                elements: section.elements.filter(isIncluded)
            )
        }
        
        return Sections(sections: newSections)
    }
    
    func filterEmptySection() -> Sections<Model, Element> {
        let newSections = sections.filter { !$0.elements.isEmpty }
            return Sections(sections: newSections)
    }
    
    func element(atSection section: Int) -> [Element] {
        sections[section].elements
    }
    
    func mapModel<R>(_ transforms: (Model) -> R) -> Sections<R, Element> {
        let newSections = sections.map { Section(model: transforms($0.model), elements: $0.elements) }
        return .init(sections: newSections)
    }
    
    func mapElement<R>(_ transform: (Element) -> R) -> Sections<Model, R> {
        let newSections = sections.map { Section(model: $0.model, elements: $0.elements.map(transform)) }
        return .init(sections: newSections)
    }
}

extension Sections: Equatable where Model: Equatable, Element: Equatable { }
extension Sections: Hashable where Model: Hashable, Element: Hashable { }

extension Sections {
    
    static var empty: Sections<Model, Element> {
        Sections()
    }
}

//// MARK: - DifferenceKit
//
//extension Sections where Model: Differentiable, Element: Differentiable {
//
//    init(from arraySections: [ArraySection<Model, Element>]) {
//        self.sections = arraySections.map {
//            Section(model: $0.model, elements: $0.elements)
//        }
//    }
//
//    func toArraySections() -> [ArraySection<Model, Element>] {
//        sections.map { ArraySection(model: $0.model, elements: $0.elements) }
//    }
//}
