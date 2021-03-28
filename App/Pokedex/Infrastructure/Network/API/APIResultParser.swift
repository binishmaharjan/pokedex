//
//  APIResultParser.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/03/28.
//

import Foundation

struct APIResultParser {
    
    static let `default` = APIResultParser(jsonDecoder: .default)
    
    private let jsonDecoder: JSONDecoder
    
    init(jsonDecoder: JSONDecoder) {
        self.jsonDecoder = jsonDecoder
    }
    
    func parseResult<SuccessResponse>(from data: Data) throws -> Result<SuccessResponse, APIDomainError> where SuccessResponse: Decodable {
        if let failureResponse = try? jsonDecoder.decode(APIDomainError.self, from: data) {
            return .failure(failureResponse)
        }
        
        let successReponse = try jsonDecoder.decode(SuccessResponse.self, from: data)
        return .success(successReponse)
    }
}
