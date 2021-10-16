//
//  List.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/10/16.
//

import Foundation

struct List {
    
    let count: Int
    let results: [ListItem]
}

struct ListItem: Equatable, Searchable, ListIdentifiable {
    
    var name: String
    let url: String
}
