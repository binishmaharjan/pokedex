import APIKit
import DIKit
import Foundation

extension APIKitHTTPClient: FactoryMethodInjectable {

    struct Dependency {
        
        let session: Session
        let apiLogger: APILogger
        

        init(session: Session, apiLogger: APILogger) {
            self.session = session
            self.apiLogger = apiLogger
            
        }
    }
    
    static func makeInstance(dependency: Dependency) -> APIKitHTTPClient {
        APIKitHTTPClient(session: dependency.session, apiLogger: dependency.apiLogger)
    }
}

extension DefaultAPIClient: FactoryMethodInjectable {

    struct Dependency {
        
        let httpClient: HTTPClient
        

        init(httpClient: HTTPClient) {
            self.httpClient = httpClient
            
        }
    }
    
    static func makeInstance(dependency: Dependency) -> DefaultAPIClient {
        DefaultAPIClient(httpClient: dependency.httpClient)
    }
}