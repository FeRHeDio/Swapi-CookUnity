//
//  DataService.swift
//  Swapi-CookUnity
//
//  Created by Fernando Putallaz on 29/10/2024.
//

import Foundation

class DataLoader: PeopleLoaderProtocol {
    let apiLoader: ApiLoader
    let dbLoader: DBLoader
    var hasMorePages: Bool {
        get { apiLoader.hasMorePages }
        set { apiLoader.hasMorePages = newValue }
    }
    
    init(apiLoader: ApiLoader, dbLoader: DBLoader, hasMorePages: Bool = true) {
        self.apiLoader = apiLoader
        self.dbLoader = dbLoader
        self.hasMorePages = hasMorePages
    }
    
    func getPeople() async throws -> [People] {
        if Reachability.networkAvailable {
            try await apiLoader.getPeople()
        } else {
            try await dbLoader.getPeople()
        }
    }
    
    func resetCollection() {
        if Reachability.networkAvailable {
            apiLoader.resetCollection()
        } else {
            dbLoader.resetCollection()
        }
    }
}
