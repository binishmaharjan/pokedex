//
//  Items.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/09/14.
//

import Foundation

struct Items {
    
    struct FlavorTextEntry {
        let text: String
    }
    
    struct EffectEntry {
        let effect: String
    }
    
    let name: String
    let id: Int
    let price: Int
    let effectEntries: [EffectEntry]
    let flavorTextEntries: [FlavorTextEntry]
}
