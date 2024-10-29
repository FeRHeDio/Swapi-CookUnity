//
//  DBLoader.swift
//  Swapi-CookUnity
//
//  Created by Fernando Putallaz on 29/10/2024.
//

import Foundation

class DBLoader: PeopleLoaderProtocol {
    var hasMorePages: Bool
    
    init(hasMorePages: Bool) {
        self.hasMorePages = hasMorePages
    }
    
    func resetCollection() {
        // Do some reset mechanism
    }
    
    func getPeople() async throws -> [People] {
        // Implementation to load People from local Database.
        return [People]()
    }
}
