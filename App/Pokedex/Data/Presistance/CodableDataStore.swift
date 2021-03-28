//
//  CodableDataStore.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/03/28.
//

import Foundation

struct CodableDataStore<Entity: Codable> {
    
    private let adaptor: CodableDataStoreAdaptor
    private let key: String
    private let defaultEntity: Entity
    
    init(adaptor: CodableDataStoreAdaptor, key: String, defaultEntity: Entity) {
        self.adaptor = adaptor
        self.key = key
        self.defaultEntity = defaultEntity
    }
}

extension CodableDataStore {
    
    func entity() -> Entity {
        guard let data = adaptor.data(forKey: key) else { return defaultEntity }
        
        do {
            return try JSONDecoder().decode(Entity.self, from: data)
        } catch {
            return defaultEntity
        }
    }
    
    func store(_ entity: Entity) throws {
        let data = try JSONEncoder().encode(entity)
        adaptor.set(data, forKey: key)
    }
    
    func removeEntity() {
        adaptor.remove(forKey: key)
    }
}
