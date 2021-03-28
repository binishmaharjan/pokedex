//
//  UserDefaultsDataStoreAdaptor.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/03/28.
//

import Foundation

struct UserDefaultsDataStoreAdaptor: CodableDataStoreAdaptor {
    
    private let userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }
    
    func data(forKey key: String) -> Data? {
        userDefaults.data(forKey: key)
    }
    
    func set(_ data: Data, forKey key: String) {
        userDefaults.set(data, forKey: key)
    }
    
    func remove(forKey key: String) {
        userDefaults.removeObject(forKey: key)
    }
}
