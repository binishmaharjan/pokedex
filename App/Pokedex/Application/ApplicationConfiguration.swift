//
//  ApplicationConfiguration.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/03/18.
//

import Foundation

/// Flag to show log
var SHOWLOG = false

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
    
    func spriteUrl(appending path: String) -> URL {
        switch self {
        
        case .debug:
            return URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites\(path)")!
        case .release:
            return URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites\(path)")!
        }
    }
}
