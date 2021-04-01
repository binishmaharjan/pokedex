//
//  PokemonListCellViewModel.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/01/17.
//

import Foundation
import ReactiveSwift

struct PokemonListCellViewModel: AutoInjectable {
    
    private let pokemon: PokemonListItem
    
    let name: Property<String>
    let id: Property<Int>
    let imageUrl: Property<URL>
    
    init(pokemon: PokemonListItem) {
        
        func idFromItem() -> Int {
            return Int(String(pokemon.url.split(separator: "/")[5]))!
        }
        
        self.pokemon = pokemon
        
        self.name = Property(value: pokemon.name.capitalized)
        self.id = Property(value: idFromItem())
        self.imageUrl = Property(value: ApplicationConfiguration.current.spriteUrl(appending: "/pokemon/other/official-artwork/\(id.value).png"))
    }
}
