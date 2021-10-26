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

    func resolveItemsListCellViewModel(item: ItemsListObject) -> ItemsListCellViewModel {
        return ItemsListCellViewModel.makeInstance(dependency: .init(item: item))
    }

    func resolveItemsListUseCase() -> ItemsListUseCase {
        let itemsRepository = resolveItemsRepository()
        return ItemsListUseCase.makeInstance(dependency: .init(itemsRepository: itemsRepository))
    }

    func resolveItemsListViewController(listRepository: ListRepository) -> ItemsListViewController {
        let appResolver = resolveAppResolver()
        let itemsListViewModel = resolveItemsListViewModel(listRepository: listRepository)
        return ItemsListViewController.makeInstance(dependency: .init(resolver: appResolver, viewModel: itemsListViewModel))
    }

    func resolveItemsListViewModel(listRepository: ListRepository) -> ItemsListViewModel {
        let listUseCase = resolveListUseCase(listRepository: listRepository)
        let itemsListUseCase = resolveItemsListUseCase()
        return ItemsListViewModel.makeInstance(dependency: .init(itemsFullListUseCase: listUseCase, itemPriceListUseCase: itemsListUseCase))
    }

    func resolveItemsRepository() -> ItemsRepository {
        return provideItemsRepository()
    }

    func resolveListUseCase(listRepository: ListRepository) -> ListUseCase {
        return ListUseCase.makeInstance(dependency: .init(listRepository: listRepository))
    }

    func resolveListViewController(listType: ListUseCase.ListType, listRepository: ListRepository) -> ListViewController {
        let appResolver = resolveAppResolver()
        let listViewModel = resolveListViewModel(listType: listType, listRepository: listRepository)
        return ListViewController.makeInstance(dependency: .init(resolver: appResolver, viewModel: listViewModel))
    }

    func resolveListViewModel(listType: ListUseCase.ListType, listRepository: ListRepository) -> ListViewModel {
        let listUseCase = resolveListUseCase(listRepository: listRepository)
        let pokemonListUseCase = resolvePokemonListUseCase()
        let itemsListUseCase = resolveItemsListUseCase()
        let movesListUseCase = resolveMovesListUseCase()
        return ListViewModel.makeInstance(dependency: .init(listType: listType, fullListUseCase: listUseCase, pokemonListUseCase: pokemonListUseCase, itemsListUseCase: itemsListUseCase, movesListUseCase: movesListUseCase))
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

    func resolveMovesListCellViewModel(move: MovesListObject) -> MovesListCellViewModel {
        return MovesListCellViewModel.makeInstance(dependency: .init(move: move))
    }

    func resolveMovesListUseCase() -> MovesListUseCase {
        let movesRepository = resolveMovesRepository()
        return MovesListUseCase.makeInstance(dependency: .init(movesRepository: movesRepository))
    }

    func resolveMovesListViewController(listRepository: ListRepository) -> MovesListViewController {
        let appResolver = resolveAppResolver()
        let movesListViewModel = resolveMovesListViewModel(listRepository: listRepository)
        return MovesListViewController.makeInstance(dependency: .init(resolver: appResolver, viewModel: movesListViewModel))
    }

    func resolveMovesListViewModel(listRepository: ListRepository) -> MovesListViewModel {
        let movesListUseCase = resolveMovesListUseCase()
        let listUseCase = resolveListUseCase(listRepository: listRepository)
        return MovesListViewModel.makeInstance(dependency: .init(movesListUseCase: movesListUseCase, movesFullListUseCase: listUseCase))
    }

    func resolveMovesRepository() -> MovesRepository {
        return provideMovesRepository()
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

    func resolvePokemonListCellViewModel(pokemon: PokemonListObject) -> PokemonListCellViewModel {
        return PokemonListCellViewModel.makeInstance(dependency: .init(pokemon: pokemon))
    }

    func resolvePokemonListUseCase() -> PokemonListUseCase {
        let pokemonRepository = resolvePokemonRepository()
        return PokemonListUseCase.makeInstance(dependency: .init(pokemonRepository: pokemonRepository))
    }

    func resolvePokemonListViewController(listRepository: ListRepository) -> PokemonListViewController {
        let appResolver = resolveAppResolver()
        let pokemonListViewModel = resolvePokemonListViewModel(listRepository: listRepository)
        return PokemonListViewController.makeInstance(dependency: .init(resolver: appResolver, viewModel: pokemonListViewModel))
    }

    func resolvePokemonListViewModel(listRepository: ListRepository) -> PokemonListViewModel {
        let pokemonListUseCase = resolvePokemonListUseCase()
        let listUseCase = resolveListUseCase(listRepository: listRepository)
        return PokemonListViewModel.makeInstance(dependency: .init(pokemonListUseCase: pokemonListUseCase, pokemonFullListUseCase: listUseCase))
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

