//
//  Resolver.swift
//  Generated by dikitgen.
//

import APIKit
import DIKit
import Foundation

extension AppResolver {

    func resolveAPIKitHTTPClient(session: Session, apiLogger: APILogger) -> APIKitHTTPClient {
        return APIKitHTTPClient.makeInstance(dependency: .init(session: session, apiLogger: apiLogger))
    }

    func resolveDefaultAPIClient(httpClient: HTTPClient) -> DefaultAPIClient {
        return DefaultAPIClient.makeInstance(dependency: .init(httpClient: httpClient))
    }

}

