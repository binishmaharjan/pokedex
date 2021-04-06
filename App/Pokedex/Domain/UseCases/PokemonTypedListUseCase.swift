//
//  PokemonListUseCase.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/04/01.
//

import Foundation

final class PokemonTypedListUseCase: AutoInjectable {
    
    struct RequestValue {
        let range: ClosedRange<Int>
    }
    
    private let pokemonRepository: PokemonRepository
    private let dispatchGroup = DispatchGroup()
    
    private var pokemonTypedListItem: [PokemonTypedListItem] = []
    private var error: APIError?
    
    init(pokemonRepository: PokemonRepository) {
        self.pokemonRepository = pokemonRepository
    }
    
    func execute(requestValue: RequestValue, _ handler: @escaping(Result<PokemonTypedList, APIError>) -> Void) -> Cancellable? {
        
        resetSavedPokemons()
        
        fetchPokemonTypes(requestValue: requestValue, handler)
        
        return nil
    }
}

private extension PokemonTypedListUseCase {
    
    func resetSavedPokemons() {
        error = nil
        pokemonTypedListItem.removeAll()
    }
    
    func fetchPokemonTypes(requestValue: RequestValue, _ handler: @escaping(Result<PokemonTypedList, APIError>) -> Void) {
        
        requestValue.range.forEach { (id) in
            DispatchQueue.global().async { [weak self] in
                guard let self = self else { return }
                self.fetchPokemonType(id: id)
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self = self else { return }
            
            self.dispatchGroup.notify(queue: .main) {

                if let error = self.error {
                    handler(.failure(error))
                    Logger.debug("TAG: Notify Error")
                } else {
                    Logger.debug("TAG: Notify Completed")
                    let sortedPokemonList = self.pokemonTypedListItem.sorted()
                    let typedList = PokemonTypedList(pokemons: sortedPokemonList)
                    handler(.success(typedList))
                }
            }
        }
    }
    
    func fetchPokemonType(id: Int) {
        dispatchGroup.enter()
        Logger.debug("TAG: DispatchQueue Enter Pokemon ID \(id)")
        
        Logger.debug("TAG: Fetching Pokemon ID \(id)")
        pokemonRepository.fetchPokemonInfo(id: id) { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let info):
                let typeItem = PokemonTypedListItem.from(pokemonInfo: info)
                self.pokemonTypedListItem.append(typeItem)
                
                Logger.debug("TAG: Fetching Pokemon ID  \(id) Completed")
                
            case .failure(let error):
                self.error = error
                Logger.debug("TAG: Fetching Pokemon ID  \(id) Error")
            }
            
            Logger.debug("TAG: DispatchQueue Leave Pokemon ID \(id)")
            self.dispatchGroup.leave()
        }
    }
}
