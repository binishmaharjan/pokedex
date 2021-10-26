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
        
        let item: ItemsListObject
        

        init(item: ItemsListObject) {
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

extension ListUseCase: FactoryMethodInjectable {

    struct Dependency {
        
        let listRepository: ListRepository
        

        init(listRepository: ListRepository) {
            self.listRepository = listRepository
            
        }
    }
    
    static func makeInstance(dependency: Dependency) -> ListUseCase {
        ListUseCase(listRepository: dependency.listRepository)
    }
}

extension ListViewController: FactoryMethodInjectable {

    struct Dependency {
        
        let resolver: AppResolver
        let viewModel: ListViewModel
        

        init(resolver: AppResolver, viewModel: ListViewModel) {
            self.resolver = resolver
            self.viewModel = viewModel
            
        }
    }
    
    static func makeInstance(dependency: Dependency) -> ListViewController {
        ListViewController(resolver: dependency.resolver, viewModel: dependency.viewModel)
    }
}

extension ListViewModel: FactoryMethodInjectable {

    struct Dependency {
        
        let listType: ListUseCase.ListType
        let fullListUseCase: ListUseCase
        let pokemonListUseCase: PokemonListUseCase
        let itemsListUseCase: ItemsListUseCase
        let movesListUseCase: MovesListUseCase
        

        init(listType: ListUseCase.ListType, fullListUseCase: ListUseCase, pokemonListUseCase: PokemonListUseCase, itemsListUseCase: ItemsListUseCase, movesListUseCase: MovesListUseCase) {
            self.listType = listType
            self.fullListUseCase = fullListUseCase
            self.pokemonListUseCase = pokemonListUseCase
            self.itemsListUseCase = itemsListUseCase
            self.movesListUseCase = movesListUseCase
            
        }
    }
    
    static func makeInstance(dependency: Dependency) -> ListViewModel {
        ListViewModel(listType: dependency.listType, fullListUseCase: dependency.fullListUseCase, pokemonListUseCase: dependency.pokemonListUseCase, itemsListUseCase: dependency.itemsListUseCase, movesListUseCase: dependency.movesListUseCase)
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

extension MovesDetailUseCase: FactoryMethodInjectable {

    struct Dependency {
        
        let movesRepository: MovesRepository
        

        init(movesRepository: MovesRepository) {
            self.movesRepository = movesRepository
            
        }
    }
    
    static func makeInstance(dependency: Dependency) -> MovesDetailUseCase {
        MovesDetailUseCase(movesRepository: dependency.movesRepository)
    }
}

extension MovesDetailViewController: FactoryMethodInjectable {

    struct Dependency {
        
        let viewModel: MovesDetailViewModel
        let resolver: AppResolver
        

        init(viewModel: MovesDetailViewModel, resolver: AppResolver) {
            self.viewModel = viewModel
            self.resolver = resolver
            
        }
    }
    
    static func makeInstance(dependency: Dependency) -> MovesDetailViewController {
        MovesDetailViewController(viewModel: dependency.viewModel, resolver: dependency.resolver)
    }
}

extension MovesDetailViewModel: FactoryMethodInjectable {

    struct Dependency {
        
        let currentIndex: Int
        let backgroundType: Type?
        let movesDetailUseCase: MovesDetailUseCase
        

        init(currentIndex: Int, backgroundType: Type?, movesDetailUseCase: MovesDetailUseCase) {
            self.currentIndex = currentIndex
            self.backgroundType = backgroundType
            self.movesDetailUseCase = movesDetailUseCase
            
        }
    }
    
    static func makeInstance(dependency: Dependency) -> MovesDetailViewModel {
        MovesDetailViewModel(currentIndex: dependency.currentIndex, backgroundType: dependency.backgroundType, movesDetailUseCase: dependency.movesDetailUseCase)
    }
}

extension MovesListCellViewModel: FactoryMethodInjectable {

    struct Dependency {
        
        let move: MovesListObject
        

        init(move: MovesListObject) {
            self.move = move
            
        }
    }
    
    static func makeInstance(dependency: Dependency) -> MovesListCellViewModel {
        MovesListCellViewModel(move: dependency.move)
    }
}

extension MovesListUseCase: FactoryMethodInjectable {

    struct Dependency {
        
        let movesRepository: MovesRepository
        

        init(movesRepository: MovesRepository) {
            self.movesRepository = movesRepository
            
        }
    }
    
    static func makeInstance(dependency: Dependency) -> MovesListUseCase {
        MovesListUseCase(movesRepository: dependency.movesRepository)
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

extension PokemonListCellViewModel: FactoryMethodInjectable {

    struct Dependency {
        
        let pokemon: PokemonListObject
        

        init(pokemon: PokemonListObject) {
            self.pokemon = pokemon
            
        }
    }
    
    static func makeInstance(dependency: Dependency) -> PokemonListCellViewModel {
        PokemonListCellViewModel(pokemon: dependency.pokemon)
    }
}

extension PokemonListUseCase: FactoryMethodInjectable {

    struct Dependency {
        
        let pokemonRepository: PokemonRepository
        

        init(pokemonRepository: PokemonRepository) {
            self.pokemonRepository = pokemonRepository
            
        }
    }
    
    static func makeInstance(dependency: Dependency) -> PokemonListUseCase {
        PokemonListUseCase(pokemonRepository: dependency.pokemonRepository)
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