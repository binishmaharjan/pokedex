import APIKit
import DIKit
import Foundation
import ReactiveCocoa
import ReactiveSwift
import UIKit

extension APIKitHTTPClient: FactoryMethodInjectable {

    struct Dependency {
        
        let session: Session
        let apiLogger: APILogger
        

        init(session: Session, apiLogger: APILogger) {
            self.session = session
            self.apiLogger = apiLogger
            
        }
    }
    
    static func makeInstance(dependency: Dependency) -> APIKitHTTPClient {
        APIKitHTTPClient(session: dependency.session, apiLogger: dependency.apiLogger)
    }
}

extension AppRootViewController: FactoryMethodInjectable {

    struct Dependency {
        
        let resolver: AppResolver
        

        init(resolver: AppResolver) {
            self.resolver = resolver
            
        }
    }
    
    static func makeInstance(dependency: Dependency) -> AppRootViewController {
        AppRootViewController(resolver: dependency.resolver)
    }
}

extension DefaultAPIClient: FactoryMethodInjectable {

    struct Dependency {
        
        let httpClient: HTTPClient
        

        init(httpClient: HTTPClient) {
            self.httpClient = httpClient
            
        }
    }
    
    static func makeInstance(dependency: Dependency) -> DefaultAPIClient {
        DefaultAPIClient(httpClient: dependency.httpClient)
    }
}

extension DefaultItemsRepository: FactoryMethodInjectable {

    struct Dependency {
        
        let apiClient: APIClient
        

        init(apiClient: APIClient) {
            self.apiClient = apiClient
            
        }
    }
    
    static func makeInstance(dependency: Dependency) -> DefaultItemsRepository {
        DefaultItemsRepository(apiClient: dependency.apiClient)
    }
}

extension DefaultMovesRepository: FactoryMethodInjectable {

    struct Dependency {
        
        let apiClient: APIClient
        

        init(apiClient: APIClient) {
            self.apiClient = apiClient
            
        }
    }
    
    static func makeInstance(dependency: Dependency) -> DefaultMovesRepository {
        DefaultMovesRepository(apiClient: dependency.apiClient)
    }
}

extension DefaultPokemonRepository: FactoryMethodInjectable {

    struct Dependency {
        
        let apiClient: APIClient
        

        init(apiClient: APIClient) {
            self.apiClient = apiClient
            
        }
    }
    
    static func makeInstance(dependency: Dependency) -> DefaultPokemonRepository {
        DefaultPokemonRepository(apiClient: dependency.apiClient)
    }
}

extension ItemDetailUseCase: FactoryMethodInjectable {

    struct Dependency {
        
        let itemsRepository: ItemsRepository
        

        init(itemsRepository: ItemsRepository) {
            self.itemsRepository = itemsRepository
            
        }
    }
    
    static func makeInstance(dependency: Dependency) -> ItemDetailUseCase {
        ItemDetailUseCase(itemsRepository: dependency.itemsRepository)
    }
}

extension ItemsDetailViewController: FactoryMethodInjectable {

    struct Dependency {
        
        let viewModel: ItemsDetailViewModel
        let resolver: AppResolver
        

        init(viewModel: ItemsDetailViewModel, resolver: AppResolver) {
            self.viewModel = viewModel
            self.resolver = resolver
            
        }
    }
    
    static func makeInstance(dependency: Dependency) -> ItemsDetailViewController {
        ItemsDetailViewController(viewModel: dependency.viewModel, resolver: dependency.resolver)
    }
}

extension ItemsDetailViewModel: FactoryMethodInjectable {

    struct Dependency {
        
        let currentIndex: Int
        let itemsDetailUseCase: ItemDetailUseCase
        

        init(currentIndex: Int, itemsDetailUseCase: ItemDetailUseCase) {
            self.currentIndex = currentIndex
            self.itemsDetailUseCase = itemsDetailUseCase
            
        }
    }
    
    static func makeInstance(dependency: Dependency) -> ItemsDetailViewModel {
        ItemsDetailViewModel(currentIndex: dependency.currentIndex, itemsDetailUseCase: dependency.itemsDetailUseCase)
    }
}

extension ItemsListCellViewModel: FactoryMethodInjectable {

    struct Dependency {
        
        let item: PriceItemsListItem
        

        init(item: PriceItemsListItem) {
            self.item = item
            
        }
    }
    
    static func makeInstance(dependency: Dependency) -> ItemsListCellViewModel {
        ItemsListCellViewModel(item: dependency.item)
    }
}

extension ItemsListUseCase: FactoryMethodInjectable {

    struct Dependency {
        
        let itemsRepository: ItemsRepository
        

        init(itemsRepository: ItemsRepository) {
            self.itemsRepository = itemsRepository
            
        }
    }
    
    static func makeInstance(dependency: Dependency) -> ItemsListUseCase {
        ItemsListUseCase(itemsRepository: dependency.itemsRepository)
    }
}

extension ItemsListViewController: FactoryMethodInjectable {

    struct Dependency {
        
        let resolver: AppResolver
        let viewModel: ItemsListViewModel
        

        init(resolver: AppResolver, viewModel: ItemsListViewModel) {
            self.resolver = resolver
            self.viewModel = viewModel
            
        }
    }
    
    static func makeInstance(dependency: Dependency) -> ItemsListViewController {
        ItemsListViewController(resolver: dependency.resolver, viewModel: dependency.viewModel)
    }
}

extension ItemsListViewModel: FactoryMethodInjectable {

    struct Dependency {
        
        let itemsFullListUseCase: ItemsListUseCase
        let itemPriceListUseCase: ItemsPriceListUseCase
        

        init(itemsFullListUseCase: ItemsListUseCase, itemPriceListUseCase: ItemsPriceListUseCase) {
            self.itemsFullListUseCase = itemsFullListUseCase
            self.itemPriceListUseCase = itemPriceListUseCase
            
        }
    }
    
    static func makeInstance(dependency: Dependency) -> ItemsListViewModel {
        ItemsListViewModel(itemsFullListUseCase: dependency.itemsFullListUseCase, itemPriceListUseCase: dependency.itemPriceListUseCase)
    }
}

extension ItemsPriceListUseCase: FactoryMethodInjectable {

    struct Dependency {
        
        let itemsRepository: ItemsRepository
        

        init(itemsRepository: ItemsRepository) {
            self.itemsRepository = itemsRepository
            
        }
    }
    
    static func makeInstance(dependency: Dependency) -> ItemsPriceListUseCase {
        ItemsPriceListUseCase(itemsRepository: dependency.itemsRepository)
    }
}

extension MainViewController: FactoryMethodInjectable {

    struct Dependency {
        
        let resolver: AppResolver
        

        init(resolver: AppResolver) {
            self.resolver = resolver
            
        }
    }
    
    static func makeInstance(dependency: Dependency) -> MainViewController {
        MainViewController(resolver: dependency.resolver)
    }
}

extension MovesFullListUseCase: FactoryMethodInjectable {

    struct Dependency {
        
        let movesRepository: MovesRepository
        

        init(movesRepository: MovesRepository) {
            self.movesRepository = movesRepository
            
        }
    }
    
    static func makeInstance(dependency: Dependency) -> MovesFullListUseCase {
        MovesFullListUseCase(movesRepository: dependency.movesRepository)
    }
}

extension MovesListCellViewModel: FactoryMethodInjectable {

    struct Dependency {
        
        let move: TypeMovesListItem
        

        init(move: TypeMovesListItem) {
            self.move = move
            
        }
    }
    
    static func makeInstance(dependency: Dependency) -> MovesListCellViewModel {
        MovesListCellViewModel(move: dependency.move)
    }
}

extension MovesListViewController: FactoryMethodInjectable {

    struct Dependency {
        
        let resolver: AppResolver
        let viewModel: MovesListViewModel
        

        init(resolver: AppResolver, viewModel: MovesListViewModel) {
            self.resolver = resolver
            self.viewModel = viewModel
            
        }
    }
    
    static func makeInstance(dependency: Dependency) -> MovesListViewController {
        MovesListViewController(resolver: dependency.resolver, viewModel: dependency.viewModel)
    }
}

extension MovesListViewModel: FactoryMethodInjectable {

    struct Dependency {
        
        let movesListUseCase: MovesTypeListUseCase
        let movesFullListUseCase: MovesFullListUseCase
        

        init(movesListUseCase: MovesTypeListUseCase, movesFullListUseCase: MovesFullListUseCase) {
            self.movesListUseCase = movesListUseCase
            self.movesFullListUseCase = movesFullListUseCase
            
        }
    }
    
    static func makeInstance(dependency: Dependency) -> MovesListViewModel {
        MovesListViewModel(movesListUseCase: dependency.movesListUseCase, movesFullListUseCase: dependency.movesFullListUseCase)
    }
}

extension MovesTypeListUseCase: FactoryMethodInjectable {

    struct Dependency {
        
        let movesRepository: MovesRepository
        

        init(movesRepository: MovesRepository) {
            self.movesRepository = movesRepository
            
        }
    }
    
    static func makeInstance(dependency: Dependency) -> MovesTypeListUseCase {
        MovesTypeListUseCase(movesRepository: dependency.movesRepository)
    }
}

extension PokemonDetailContentViewController: FactoryMethodInjectable {

    struct Dependency {
        
        let viewModel: PokemonDetailContentViewModel
        

        init(viewModel: PokemonDetailContentViewModel) {
            self.viewModel = viewModel
            
        }
    }
    
    static func makeInstance(dependency: Dependency) -> PokemonDetailContentViewController {
        PokemonDetailContentViewController(viewModel: dependency.viewModel)
    }
}

extension PokemonDetailContentViewModel: FactoryMethodInjectable {

    struct Dependency {
        
        let pokemonId: Int
        let pokemonDetailUseCase: PokemonDetailUseCase
        

        init(pokemonId: Int, pokemonDetailUseCase: PokemonDetailUseCase) {
            self.pokemonId = pokemonId
            self.pokemonDetailUseCase = pokemonDetailUseCase
            
        }
    }
    
    static func makeInstance(dependency: Dependency) -> PokemonDetailContentViewModel {
        PokemonDetailContentViewModel(pokemonId: dependency.pokemonId, pokemonDetailUseCase: dependency.pokemonDetailUseCase)
    }
}

extension PokemonDetailUseCase: FactoryMethodInjectable {

    struct Dependency {
        
        let pokemonRepository: PokemonRepository
        

        init(pokemonRepository: PokemonRepository) {
            self.pokemonRepository = pokemonRepository
            
        }
    }
    
    static func makeInstance(dependency: Dependency) -> PokemonDetailUseCase {
        PokemonDetailUseCase(pokemonRepository: dependency.pokemonRepository)
    }
}

extension PokemonDetailViewController: FactoryMethodInjectable {

    struct Dependency {
        
        let viewModel: PokemonDetailViewModel
        let resolver: AppResolver
        

        init(viewModel: PokemonDetailViewModel, resolver: AppResolver) {
            self.viewModel = viewModel
            self.resolver = resolver
            
        }
    }
    
    static func makeInstance(dependency: Dependency) -> PokemonDetailViewController {
        PokemonDetailViewController(viewModel: dependency.viewModel, resolver: dependency.resolver)
    }
}

extension PokemonDetailViewModel: FactoryMethodInjectable {

    struct Dependency {
        
        let pokemonId: Int
        let backgroundType: Type?
        let pokemonDetailUseCase: PokemonDetailUseCase
        

        init(pokemonId: Int, backgroundType: Type?, pokemonDetailUseCase: PokemonDetailUseCase) {
            self.pokemonId = pokemonId
            self.backgroundType = backgroundType
            self.pokemonDetailUseCase = pokemonDetailUseCase
            
        }
    }
    
    static func makeInstance(dependency: Dependency) -> PokemonDetailViewModel {
        PokemonDetailViewModel(pokemonId: dependency.pokemonId, backgroundType: dependency.backgroundType, pokemonDetailUseCase: dependency.pokemonDetailUseCase)
    }
}

extension PokemonFullListUseCase: FactoryMethodInjectable {

    struct Dependency {
        
        let pokemonRepository: PokemonRepository
        

        init(pokemonRepository: PokemonRepository) {
            self.pokemonRepository = pokemonRepository
            
        }
    }
    
    static func makeInstance(dependency: Dependency) -> PokemonFullListUseCase {
        PokemonFullListUseCase(pokemonRepository: dependency.pokemonRepository)
    }
}

extension PokemonListCellViewModel: FactoryMethodInjectable {

    struct Dependency {
        
        let pokemon: TypePokemonListItem
        

        init(pokemon: TypePokemonListItem) {
            self.pokemon = pokemon
            
        }
    }
    
    static func makeInstance(dependency: Dependency) -> PokemonListCellViewModel {
        PokemonListCellViewModel(pokemon: dependency.pokemon)
    }
}

extension PokemonListViewController: FactoryMethodInjectable {

    struct Dependency {
        
        let resolver: AppResolver
        let viewModel: PokemonListViewModel
        

        init(resolver: AppResolver, viewModel: PokemonListViewModel) {
            self.resolver = resolver
            self.viewModel = viewModel
            
        }
    }
    
    static func makeInstance(dependency: Dependency) -> PokemonListViewController {
        PokemonListViewController(resolver: dependency.resolver, viewModel: dependency.viewModel)
    }
}

extension PokemonListViewModel: FactoryMethodInjectable {

    struct Dependency {
        
        let pokemonListUseCase: PokemonTypedListUseCase
        let pokemonFullListUseCase: PokemonFullListUseCase
        

        init(pokemonListUseCase: PokemonTypedListUseCase, pokemonFullListUseCase: PokemonFullListUseCase) {
            self.pokemonListUseCase = pokemonListUseCase
            self.pokemonFullListUseCase = pokemonFullListUseCase
            
        }
    }
    
    static func makeInstance(dependency: Dependency) -> PokemonListViewModel {
        PokemonListViewModel(pokemonListUseCase: dependency.pokemonListUseCase, pokemonFullListUseCase: dependency.pokemonFullListUseCase)
    }
}

extension PokemonTypedListUseCase: FactoryMethodInjectable {

    struct Dependency {
        
        let pokemonRepository: PokemonRepository
        

        init(pokemonRepository: PokemonRepository) {
            self.pokemonRepository = pokemonRepository
            
        }
    }
    
    static func makeInstance(dependency: Dependency) -> PokemonTypedListUseCase {
        PokemonTypedListUseCase(pokemonRepository: dependency.pokemonRepository)
    }
}

extension SplashViewController: FactoryMethodInjectable {

    struct Dependency {
        
        

        init() {
            
        }
    }
    
    static func makeInstance(dependency: Dependency) -> SplashViewController {
        SplashViewController()
    }
}