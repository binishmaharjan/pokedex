//
//  NSObject+Extension.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/03/28.
//

import Foundation

extension NSObject {
    
    static var className: String {
        return String(describing: Self.self)
    }
}
