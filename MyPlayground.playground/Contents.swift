import UIKit

struct HTTPHeader: Hashable {
    
    struct Key: Hashable {
        
        let rawValue: String
        
        init(_ rawValue: String) {
            self.rawValue = rawValue
        }
    }
    
    let key: Key
    let value: String?
}

struct HTTPHeaderFields: Hashable {
    
    static let empty = HTTPHeaderFields(headers: [])
    
    let headers: [HTTPHeader]
    
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

let authorization = HTTPHeader(key: .init("X-Authorization"), value: "XXXXX")
let authorization2 = HTTPHeader(key: .init("X-Authorization"), value: "YYYYYY")
let clientID = HTTPHeader(key: .init("X-Client"), value: "CCCCC")
let clientSecret = HTTPHeader(key: .init("X-Secrect"), value: "SSSSS")

let lhsHeader = HTTPHeaderFields(headers: [authorization, clientID])
let rhsHeader = HTTPHeaderFields(headers: [clientSecret, authorization2])

let merged = lhsHeader.merging(with: rhsHeader, uniqueKeysWith: { a, b in a })
print(merged)

