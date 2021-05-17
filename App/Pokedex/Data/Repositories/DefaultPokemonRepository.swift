//
//  DefaultPokemonRepository.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/04/02.
//

import Foundation

final class DefaultPokemonRepository: PokemonRepository, AutoInjectable {
    
    // MARK: Properties
    private let apiClient: APIClient
    
    // MARK: Pokemon Typed List Properties
    private let dispatchGroup = DispatchGroup()
    private var pokemonList: [PokemonTypedListItem] = []
    private var error: APIError?
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func fetchPokemonList(offset: Int, limit: Int, _ handler: @escaping (Result<[PokemonListItem], APIError>) -> Void) -> Cancellable? {
        let request = PokemonListRequest(offset: offset, limit: limit)
        
        let task = apiClient.send(request) { (result) in
            switch result {
            case .success(let responseDTO):
                let pokemonList = responseDTO.toDomain()
                handler(.success(pokemonList.pokemons))
            case .failure(let error):
                handler(.failure(error))
            }
        }

        return task
    }
    
    func fetchPokemonInfo(id: Int, _ handler: @escaping (Result<PokemonInfo, APIError>) ->Void) -> Cancellable? {
        let request = PokemonInfoRequest(id: id)
        
        let task = apiClient.send(request) { (result) in
            switch result {
            case .success(let response):
                handler(.success(response.toDomain()))
            case .failure(let error):
                handler(.failure(error))
            }
        }
        
        return task
    }
    
    func fetchPokemonInfoList(requestValue: ClosedRange<Int>, _ handler: @escaping (Result<[PokemonTypedListItem], APIError>) -> Void) -> Cancellable? {
        // Reset Saved values
        error = nil
        pokemonList.removeAll()
        
        // Send request for all Pokemon in the request value
        requestValue.forEach { id in
            dispatchGroup.enter()
            
            let request = PokemonInfoRequest(id: id)
            
            let task = apiClient.send(request) { [weak self] result in
                
                guard let self = self else { return }
                
                switch result {
                case .success(let info):
                    let typeItem = PokemonTypedListItem.from(pokemonInfo: info.toDomain())
                    self.pokemonList.append(typeItem)
                    
                case .failure(let error):
                    self.error = error
                }
                
                self.dispatchGroup.leave()
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            
            guard let self = self else { return }
            
            self.dispatchGroup.notify(queue: .main) {
                if let error = self.error {
                    handler(.failure(error))
                } else {
                    let sortedList = self.pokemonList.sorted()
                    handler(.success(sortedList))
                }
            }
        }
        
        return nil
    }
}
