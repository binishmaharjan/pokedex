import APIKit
import DIKit
import Foundation
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
        

        init(pokemonId: Int) {
            self.pokemonId = pokemonId
            
        }
    }
    
    static func makeInstance(dependency: Dependency) -> PokemonDetailContentViewModel {
        PokemonDetailContentViewModel(pokemonId: dependency.pokemonId)
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
        let backgroundType: TypeName?
        

        init(pokemonId: Int, backgroundType: TypeName?) {
            self.pokemonId = pokemonId
            self.backgroundType = backgroundType
            
        }
    }
    
    static func makeInstance(dependency: Dependency) -> PokemonDetailViewModel {
        PokemonDetailViewModel(pokemonId: dependency.pokemonId, backgroundType: dependency.backgroundType)
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
        
        let pokemon: PokemonTypedListItem
        

        init(pokemon: PokemonTypedListItem) {
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