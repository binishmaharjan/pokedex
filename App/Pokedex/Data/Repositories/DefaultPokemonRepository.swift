//
//  DefaultPokemonRepository.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/04/02.
//

import Foundation
import ReactiveSwift
import ReactiveCocoa

final class DefaultPokemonRepository: PokemonRepository, AutoInjectable {
    
    // MARK: Properties
    private let apiClient: APIClient
    
    // MARK: Pokemon Typed List Properties
    private let dispatchGroup = DispatchGroup()
    private var pokemonList: [PokemonListItem] = []
    private var error: APIError?
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    /// Fetch pokemon list not including pokemon type
    @discardableResult
    func fetchList(offset: Int, limit: Int, _ handler: @escaping(Result<[ListItem], APIError>) -> Void) -> Cancellable? {
        let request = PokemonListRequest(offset: offset, limit: limit)
        
        let task = apiClient.send(request) { (result) in
            switch result {
            case .success(let responseDTO):
                let pokemonList = responseDTO.toDomain()
                handler(.success(pokemonList.results))
            case .failure(let error):
                handler(.failure(error))
            }
        }

        return task
    }
    
    /// Fetch master data, which contains full pokemon info
    func fetchMasterPokemonData(id: Int, _ handler: @escaping (Result<MasterPokemonData, APIError>) -> Void) -> Cancellable? {
        
        let pokemonRequest = PokemonRequest(id: id)
        let pokemonSpeciesRequest = PokemonSpeciesRequest(id: id)
        
        let disposable = SignalProducer
            .zip(apiClient.send(pokemonRequest),
                 apiClient.send(pokemonSpeciesRequest))
            .map { pokemon, pokemonSpecies in
                MasterPokemonData(
                    id: pokemon.id,
                    name: pokemon.name,
                    types: pokemon.types.map { $0.toDomain() },
                    stats: pokemon.stats.map { $0.toDomain() },
                    flavorTextEntries:  pokemonSpecies.flavorTextEntries.map { $0.toDomain() },
                    captureRate: pokemonSpecies.captureRate,
                    habitat: pokemonSpecies.habitat.toDomain(),
                    generation: pokemonSpecies.generation.toDomain()
                )
            }.startWithResult(handler)
        
        return AnyCancellable(disposable.dispose)
    }
    
    /// Fetch pokemon list including pokemon type
    func fetchPokemonList(requestValue: ClosedRange<Int>, _ handler: @escaping (Result<[PokemonListItem], APIError>) -> Void) -> Cancellable? {
        // Reset Saved values
        error = nil
        pokemonList.removeAll()
        
        // Send request for all Pokemon in the request value
        requestValue.forEach { id in
            dispatchGroup.enter()
            
            let request = PokemonRequest(id: id)
            
            let _ = apiClient.send(request) { [weak self] result in
                
                guard let self = self else { return }
                
                switch result {
                case .success(let info):
                    let typeItem = PokemonListItem.from(info.toDomain())
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
