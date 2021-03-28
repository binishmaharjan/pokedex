//
//  HTTPError.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/03/25.
//

import Foundation

enum HTTPError: Error, Hashable {
    
    case connectionError
    case invalidResponseError
}
