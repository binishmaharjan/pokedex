//
//  PokemonListUseCase.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/04/01.
//

import Foundation

final class PokemonListUseCase: AutoInjectable {
    
    struct RequestValue {
        let offset: Int
        let limit: Int
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
        
        pokemonRepository.fetchPokemonList(offset: requestValue.offset, limit: requestValue.limit) { [weak self] (result) in
            guard let self = self else { return
                
            }
            switch result {
            case .success(let list):
                self.fetchPokemonTypes(pokemonList: list, handler)
                
            case .failure(let error):
                handler(.failure(error))
            }
        }
        
        return nil
    }
}

private extension PokemonListUseCase {
    
    func resetSavedPokemons() {
        error = nil
        pokemonTypedListItem.removeAll()
    }
    
    func idFromItem(url: String) -> Int {
        return Int(String(url.split(separator: "/")[5]))!
    }
    
    func fetchPokemonTypes(pokemonList: PokemonList, _ handler: @escaping(Result<PokemonTypedList, APIError>) -> Void) {
        
        pokemonList.pokemons.forEach { (item) in
            DispatchQueue.global().async { [weak self] in
                guard let self = self else { return }
                self.fetchPokemonType(pokemonItem: item)
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
                    let typedList = PokemonTypedList(count: pokemonList.count, pokemons: sortedPokemonList)
                    handler(.success(typedList))
                }
            }
        }
    }
    
    func fetchPokemonType(pokemonItem: PokemonListItem) {
        dispatchGroup.enter()
        Logger.debug("TAG: DispatchQueue Enter \(pokemonItem.name)")
        
        let id = idFromItem(url: pokemonItem.url)
        
        Logger.debug("TAG: Fetching \(pokemonItem.name)")
        pokemonRepository.fetchPokemonInfo(id: id) { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let info):
                let typeItem = PokemonTypedListItem.from(pokemonInfo: info)
                self.pokemonTypedListItem.append(typeItem)
                
                Logger.debug("TAG: Fetching \(pokemonItem.name) Completed")
                
            case .failure(let error):
                self.error = error
                Logger.debug("TAG: Fetching \(pokemonItem.name) Error")
            }
            
            Logger.debug("TAG: DispatchQueue Leave \(pokemonItem.name)")
            self.dispatchGroup.leave()
        }
    }
}
