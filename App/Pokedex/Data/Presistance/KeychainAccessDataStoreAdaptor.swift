//
//  KeychainAccessDataStoreAdaptor.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/03/28.
//

import Foundation
import KeychainAccess
    
struct KeychainAccessDataStoreAdaptor: CodableDataStoreAdaptor {
    
    static let shared = KeychainAccessDataStoreAdaptor(keychain: Keychain(service: Bundle.main.bundleIdentifier!))
    
    private let keychain: Keychain
    
    init(keychain: Keychain) {
        self.keychain = keychain
    }
    
    func data(forKey key: String) -> Data? {
        try? keychain.getData(key)
    }
    
    func set(_ data: Data, forKey key: String) {
        try? keychain.set(data, key: key)
    }
    
    func remove(forKey key: String) {
        try? keychain.remove(key)
    }
}
