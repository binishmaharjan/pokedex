//
//  HTTP.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/03/24.
//

import Foundation

enum HTTP {
    
    enum Method: String {
        case get
        case post
    }
    
    enum MimeType: String {
        case applicationJSON = "application/json"
    }
}
