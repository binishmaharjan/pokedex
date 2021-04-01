//
//  DefaultPokemonRepository.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/04/02.
//

import Foundation

final class DefaultPokemonRepository: PokemonRepository, AutoInjectable {
    
    private let apiClient: APIClient
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func fetchPokemonList(offset: Int, limit: Int, _ handler: @escaping (Result<PokemonList, APIError>) -> Void) -> Cancellable? {
        let request = PokemonListRequest(offset: offset, limit: limit)
        
        let task = apiClient.send(request) { (result) in
            switch result {
            case .success(let responseDTO):
                handler(.success(responseDTO.toDomain()))
            case .failure(let error):
                handler(.failure(error))
            }
        }

        return task
    }
}
