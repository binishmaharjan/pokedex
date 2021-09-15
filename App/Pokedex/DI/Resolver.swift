//
//  Resolver.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/03/17.
//

import Foundation
import DIKit
import APIKit

protocol AppResolver: Resolver {
    
    func provideAppResolver() -> AppResolver
    func provideUserDefaults() -> UserDefaults
    func provideAPILogger() -> APILogger
    func provideSession() -> Session
    func provideHTTPClient() -> HTTPClient
    func provideAPIClient() -> APIClient
    
    
    // MARK: Repositories
    func providePokemonRepository() -> PokemonRepository
    func provideMovesRepository() -> MovesRepository
    func provideItemsRepository() -> ItemsRepository
}

extension AppResolver {
    
    func provideAppResolver() -> AppResolver {
        self
    }
    
    func provideUserDefaults() -> UserDefaults {
        .standard
    }
    
    func provideAPILogger() -> APILogger {
        DefaultAPILogger()
    }
    
    func provideSession() -> Session {
        APIKitAdaptor.session
    }
    
    func provideHTTPClient() -> HTTPClient {
        resolveAPIKitHTTPClient()
    }
    
    func provideAPIClient() -> APIClient {
        resolveDefaultAPIClient()
    }
}

// MARK: Repositories

extension AppResolver {
    
    func providePokemonRepository() -> PokemonRepository {
        resolveDefaultPokemonRepository()
    }
    
    func provideMovesRepository() -> MovesRepository {
        resolveDefaultMovesRepository()
    }
    
    func provideItemsRepository() -> ItemsRepository {
        resolveDefaultItemsRepository()
    }
}
