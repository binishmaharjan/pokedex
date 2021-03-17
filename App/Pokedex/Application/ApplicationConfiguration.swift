//
//  ApplicationConfiguration.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/03/18.
//

import Foundation

enum ApplicationConfiguration {
    
    case debug
    case release
}

extension ApplicationConfiguration {
    
    static var current: ApplicationConfiguration = {
        
        #if API_DEVELOPMENT
        return ApplicationConfiguration.debug
        
        #elseif API_RELEASE
        return ApplicationConfiguration.release
        
        #endif
    }()
}

extension ApplicationConfiguration {
    
    var apiServerUrl: URL {
        switch self {
        
        case .debug:
            return URL(string: "https://pokeapi.co/api/v2")!
            
        case .release:
            return URL(string: "https://pokeapi.co/api/v2")!
        }
    }
}
