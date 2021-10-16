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
    let typeOne: Property<Type?>
    let typeTwo: Property<Type?>
    
    init(pokemon: PokemonListItem) {
        
        self.pokemon = pokemon
        
        self.name = Property(value: pokemon.name.capitalized)
        self.id = Property(value: pokemon.id)
        self.imageUrl = Property(value: ApplicationConfiguration.current.spriteUrl(appending: "/pokemon/other/official-artwork/\(pokemon.id).png"))
        
        let slot1 = pokemon.elements.filter { $0.slot == 1 }
        let typeOne = slot1.first?.type.name ?? nil
        self.typeOne = Property(value: typeOne)

        let slot2 = pokemon.elements.filter { $0.slot == 2 }
        let typeTwo = slot2.first?.type.name ?? nil
        self.typeTwo = Property(value: typeTwo)
    }
}
