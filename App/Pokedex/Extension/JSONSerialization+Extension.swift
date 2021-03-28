//
//  JSONSerialization+Extension.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/03/28.
//

import Foundation

extension JSONSerialization {
    
    private static let failedText = "failed to decode"
    
    static func prettyJSON(of data: Data?) -> String {
        guard let data = data, let object = try? jsonObject(with: data, options: []) else {
            return failedText
        }
        
        return prettyJSON(of: object)
    }
    
    static func prettyJSON(of object: Any) -> String {
        guard let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted, .sortedKeys]) else {
            return failedText
        }
        
        return String(data: data, encoding: .utf8) ?? failedText
    }
}
