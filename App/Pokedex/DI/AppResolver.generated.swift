//
//  Resolver.swift
//  Generated by dikitgen.
//

import APIKit
import DIKit
import Foundation
import ReactiveCocoa
import ReactiveSwift
import UIKit

extension AppResolver {

    func resolveAPIClient() -> APIClient {
        return provideAPIClient()
    }

    func resolveAPIKitHTTPClient() -> APIKitHTTPClient {
        let session = resolveSession()
        let apiLogger = resolveAPILogger()
        return APIKitHTTPClient.makeInstance(dependency: .init(session: session, apiLogger: apiLogger))
    }

    func resolveAPILogger() -> APILogger {
        return provideAPILogger()
    }

    func resolveAppResolver() -> AppResolver {
        return provideAppResolver()
    }

    func resolveAppRootViewController() -> AppRootViewController {
        let appResolver = resolveAppResolver()
        return AppRootViewController.makeInstance(dependency: .init(resolver: appResolver))
    }

    func resolveDefaultAPIClient() -> DefaultAPIClient {
        let httpClient = resolveHTTPClient()
        return DefaultAPIClient.makeInstance(dependency: .init(httpClient: httpClient))
    }

    func resolveDefaultItemsRepository() -> DefaultItemsRepository {
        let apiClient = resolveAPIClient()
        return DefaultItemsRepository.makeInstance(dependency: .init(apiClient: apiClient))
    }

    func resolveDefaultMovesRepository() -> DefaultMovesRepository {
        let apiClient = resolveAPIClient()
        return DefaultMovesRepository.makeInstance(dependency: .init(apiClient: apiClient))
    }

    func resolveDefaultPokemonRepository() -> DefaultPokemonRepository {
        let apiClient = resolveAPIClient()
        return DefaultPokemonRepository.makeInstance(dependency: .init(apiClient: apiClient))
    }

    func resolveHTTPClient() -> HTTPClient {
        return provideHTTPClient()
    }

    func resolveItemDetailUseCase() -> ItemDetailUseCase {
        let itemsRepository = resolveItemsRepository()
        return ItemDetailUseCase.makeInstance(dependency: .init(itemsRepository: itemsRepository))
    }

    func resolveItemsDetailViewController(currentIndex: Int) -> ItemsDetailViewController {
        let itemsDetailViewModel = resolveItemsDetailViewModel(currentIndex: currentIndex)
        let appResolver = resolveAppResolver()
        return ItemsDetailViewController.makeInstance(dependency: .init(viewModel: itemsDetailViewModel, resolver: appResolver))
    }

    func resolveItemsDetailViewModel(currentIndex: Int) -> ItemsDetailViewModel {
        let itemDetailUseCase = resolveItemDetailUseCase()
        return ItemsDetailViewModel.makeInstance(dependency: .init(currentIndex: currentIndex, itemsDetailUseCase: itemDetailUseCase))
    }

    func resolveItemsListCellViewModel(item: PriceItemsListItem) -> ItemsListCellViewModel {
        return ItemsListCellViewModel.makeInstance(dependency: .init(item: item))
    }

    func resolveItemsListUseCase() -> ItemsListUseCase {
        let itemsRepository = resolveItemsRepository()
        return ItemsListUseCase.makeInstance(dependency: .init(itemsRepository: itemsRepository))
    }

    func resolveItemsListViewController() -> ItemsListViewController {
        let appResolver = resolveAppResolver()
        let itemsListViewModel = resolveItemsListViewModel()
        return ItemsListViewController.makeInstance(dependency: .init(resolver: appResolver, viewModel: itemsListViewModel))
    }

    func resolveItemsListViewModel() -> ItemsListViewModel {
        let itemsListUseCase = resolveItemsListUseCase()
        let itemsPriceListUseCase = resolveItemsPriceListUseCase()
        return ItemsListViewModel.makeInstance(dependency: .init(itemsFullListUseCase: itemsListUseCase, itemPriceListUseCase: itemsPriceListUseCase))
    }

    func resolveItemsPriceListUseCase() -> ItemsPriceListUseCase {
        let itemsRepository = resolveItemsRepository()
        return ItemsPriceListUseCase.makeInstance(dependency: .init(itemsRepository: itemsRepository))
    }

    func resolveItemsRepository() -> ItemsRepository {
        return provideItemsRepository()
    }

    func resolveMainViewController() -> MainViewController {
        let appResolver = resolveAppResolver()
        return MainViewController.makeInstance(dependency: .init(resolver: appResolver))
    }

    func resolveMovesDetailUseCase() -> MovesDetailUseCase {
        let movesRepository = resolveMovesRepository()
        return MovesDetailUseCase.makeInstance(dependency: .init(movesRepository: movesRepository))
    }

    func resolveMovesDetailViewController(currentIndex: Int, backgroundType: Type?) -> MovesDetailViewController {
        let movesDetailViewModel = resolveMovesDetailViewModel(currentIndex: currentIndex, backgroundType: backgroundType)
        let appResolver = resolveAppResolver()
        return MovesDetailViewController.makeInstance(dependency: .init(viewModel: movesDetailViewModel, resolver: appResolver))
    }

    func resolveMovesDetailViewModel(currentIndex: Int, backgroundType: Type?) -> MovesDetailViewModel {
        let movesDetailUseCase = resolveMovesDetailUseCase()
        return MovesDetailViewModel.makeInstance(dependency: .init(currentIndex: currentIndex, backgroundType: backgroundType, movesDetailUseCase: movesDetailUseCase))
    }

    func resolveMovesFullListUseCase() -> MovesFullListUseCase {
        let movesRepository = resolveMovesRepository()
        return MovesFullListUseCase.makeInstance(dependency: .init(movesRepository: movesRepository))
    }

    func resolveMovesListCellViewModel(move: TypeMovesListItem) -> MovesListCellViewModel {
        return MovesListCellViewModel.makeInstance(dependency: .init(move: move))
    }

    func resolveMovesListViewController() -> MovesListViewController {
        let appResolver = resolveAppResolver()
        let movesListViewModel = resolveMovesListViewModel()
        return MovesListViewController.makeInstance(dependency: .init(resolver: appResolver, viewModel: movesListViewModel))
    }

    func resolveMovesListViewModel() -> MovesListViewModel {
        let movesTypeListUseCase = resolveMovesTypeListUseCase()
        let movesFullListUseCase = resolveMovesFullListUseCase()
        return MovesListViewModel.makeInstance(dependency: .init(movesListUseCase: movesTypeListUseCase, movesFullListUseCase: movesFullListUseCase))
    }

    func resolveMovesRepository() -> MovesRepository {
        return provideMovesRepository()
    }

    func resolveMovesTypeListUseCase() -> MovesTypeListUseCase {
        let movesRepository = resolveMovesRepository()
        return MovesTypeListUseCase.makeInstance(dependency: .init(movesRepository: movesRepository))
    }

    func resolvePokemonDetailContentViewController(pokemonId: Int) -> PokemonDetailContentViewController {
        let pokemonDetailContentViewModel = resolvePokemonDetailContentViewModel(pokemonId: pokemonId)
        return PokemonDetailContentViewController.makeInstance(dependency: .init(viewModel: pokemonDetailContentViewModel))
    }

    func resolvePokemonDetailContentViewModel(pokemonId: Int) -> PokemonDetailContentViewModel {
        let pokemonDetailUseCase = resolvePokemonDetailUseCase()
        return PokemonDetailContentViewModel.makeInstance(dependency: .init(pokemonId: pokemonId, pokemonDetailUseCase: pokemonDetailUseCase))
    }

    func resolvePokemonDetailUseCase() -> PokemonDetailUseCase {
        let pokemonRepository = resolvePokemonRepository()
        return PokemonDetailUseCase.makeInstance(dependency: .init(pokemonRepository: pokemonRepository))
    }

    func resolvePokemonDetailViewController(pokemonId: Int, backgroundType: Type?) -> PokemonDetailViewController {
        let pokemonDetailViewModel = resolvePokemonDetailViewModel(pokemonId: pokemonId, backgroundType: backgroundType)
        let appResolver = resolveAppResolver()
        return PokemonDetailViewController.makeInstance(dependency: .init(viewModel: pokemonDetailViewModel, resolver: appResolver))
    }

    func resolvePokemonDetailViewModel(pokemonId: Int, backgroundType: Type?) -> PokemonDetailViewModel {
        let pokemonDetailUseCase = resolvePokemonDetailUseCase()
        return PokemonDetailViewModel.makeInstance(dependency: .init(pokemonId: pokemonId, backgroundType: backgroundType, pokemonDetailUseCase: pokemonDetailUseCase))
    }

    func resolvePokemonFullListUseCase() -> PokemonFullListUseCase {
        let pokemonRepository = resolvePokemonRepository()
        return PokemonFullListUseCase.makeInstance(dependency: .init(pokemonRepository: pokemonRepository))
    }

    func resolvePokemonListCellViewModel(pokemon: PokemonListItem) -> PokemonListCellViewModel {
        return PokemonListCellViewModel.makeInstance(dependency: .init(pokemon: pokemon))
    }

    func resolvePokemonListUseCase() -> PokemonListUseCase {
        let pokemonRepository = resolvePokemonRepository()
        return PokemonListUseCase.makeInstance(dependency: .init(pokemonRepository: pokemonRepository))
    }

    func resolvePokemonListViewController() -> PokemonListViewController {
        let appResolver = resolveAppResolver()
        let pokemonListViewModel = resolvePokemonListViewModel()
        return PokemonListViewController.makeInstance(dependency: .init(resolver: appResolver, viewModel: pokemonListViewModel))
    }

    func resolvePokemonListViewModel() -> PokemonListViewModel {
        let pokemonListUseCase = resolvePokemonListUseCase()
        let pokemonFullListUseCase = resolvePokemonFullListUseCase()
        return PokemonListViewModel.makeInstance(dependency: .init(pokemonListUseCase: pokemonListUseCase, pokemonFullListUseCase: pokemonFullListUseCase))
    }

    func resolvePokemonRepository() -> PokemonRepository {
        return providePokemonRepository()
    }

    func resolveSession() -> Session {
        return provideSession()
    }

    func resolveSplashViewController() -> SplashViewController {
        return SplashViewController.makeInstance(dependency: .init())
    }

    func resolveUserDefaults() -> UserDefaults {
        return provideUserDefaults()
    }

}

