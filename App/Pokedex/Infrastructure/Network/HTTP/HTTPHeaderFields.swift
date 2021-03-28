//
//  HTTPHeaderFields.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/03/25.
//

import Foundation

struct HTTPHeaderFields: Hashable {
    
    static let empty = HTTPHeaderFields(headers: [])
    
    private let headers: [HTTPHeader]
    
    init(headers: [HTTPHeader]) {
        self.headers = headers
    }
    
    var dictionary: [String: String] {
        let group = Dictionary(grouping: headers, by: \.key.rawValue)
        return group.compactMapValues { $0[0].value }
    }
    
    func merging(with other: HTTPHeaderFields, uniqueKeysWith combine: (HTTPHeader, HTTPHeader) -> HTTPHeader) -> HTTPHeaderFields {
        let lhs = Dictionary(grouping: headers, by: \.key).mapValues { $0[0] }
        let rhs = Dictionary(grouping: other.headers, by: \.key).mapValues { $0[0] }
        let merged = lhs.merging(rhs, uniquingKeysWith: combine)
        return HTTPHeaderFields(headers: Array(merged.values))
    }
}

/*
 let authorization = HTTPHeader(key: .init("X-Authorization"), value: "XXXXX")
 let authorization2 = HTTPHeader(key: .init("X-Authorization"), value: "YYYYYY")
 let clientID = HTTPHeader(key: .init("X-Client"), value: "CCCCC")
 let clientSecrect = HTTPHeader(key: .init("X-Secrect"), value: "SSSSS")
 
 let header = HTTPHeaderFields(headers: [authorization, clientID, authorization2])
 
 // Create Dictionary with HTTPHeader.Key as Key for grouping
 let dictionary: [HTTPHeader.Key : [HTTPHeader]] = Dictionary(grouping: header, by: \.key)
 **Result**
 [
    HTTPHeader.Key(rawValue: "X-Authorization"): [
                                                    HTTPHeader(key: "X-Authorization", value: "XXXXXX"),
                                                    HTTPHeader(key: "X-Authorization", value: "YYYYYY"),
                                                  ],
    HTTPHeader.Key(rawValue: "X-Client"): [HTTPHeader(key: "X-Client", value: "CCCCC")],
 ]
 
 // Creates Dictionary with HTTPHeader.Key as key for grouping with value transformed by the given closure by using mapValue
 
 // In below example if only takes first value form the Value array
 let dictionary: [HTTPHeader.Key : HTTPHeader] = Dictionary(grouping: header, by: \.key).mapValue { $0[0] }
 **Result**
 [
    HTTPHeader.Key(rawValue: "X-Authorization"): HTTPHeader(key: "X-Authorization", value: "XXXXXX"),
    HTTPHeader.Key(rawValue: "X-Client"): HTTPHeader(key: "X-Client", value: "CCCCC"),
 ]
 
 
 /// Merged
 merges the headerfields of rhs and lhs. if lhs and rhs has same key then the HTTPHeaderFields returned in the closure has higher priority
 
 let lhsHeader = HTTPHeaderFields(headers: [authorization, clientID])
 let rhsHeader = HTTPHeaderFields(headers: [clientSecrect, authorization2])
 
 let merged: [HTTPHeaderFields] = lhsHeader.merging(with: rhsHeader, uniqueKeysWith: { lhs, rhs in lhs })
 **Result**
 HTTPHeaderFields(headers: [
    HTTPHeader(key: .init("X-Authorization"), value: "XXXXX"),
    HTTPHeader(key: .init("X-Client"), value: "CCCCC"),
    HTTPHeader(key: .init("X-Secrect"), value: "SSSSS")
 ])
 
 let merged2: [HTTPHeaderFields] = lhsHeader.merging(with: rhsHeader, uniqueKeysWith: { lhs, rhs in rhs })
 **Result**
 HTTPHeaderFields(headers: [
    HTTPHeader(key: .init("X-Authorization"), value: "YYYY"),
    HTTPHeader(key: .init("X-Client"), value: "CCCCC"),
    HTTPHeader(key: .init("X-Secrect"), value: "SSSSS")
 ])
 */
