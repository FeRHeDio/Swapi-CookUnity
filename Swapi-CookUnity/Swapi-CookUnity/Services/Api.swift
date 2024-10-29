//
//  Api.swift
//  Swapi-CookUnity
//
//  Created by Fernando Putallaz on 25/10/2024.
//

import Foundation

protocol PeopleLoaderProtocol {
    func getPeople() async throws -> [People]
    func resetCollection()
    var hasMorePages: Bool { get set }
}

class ApiLoader: PeopleLoaderProtocol {
    func getPeople() async throws -> [People] {
        do {
            guard let url = URL(string: url) else {
                throw URLError(.badURL)
            }
            
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw URLError(.badServerResponse)
            }
            
            guard httpResponse.statusCode == 200 else {
                throw URLError(.badServerResponse)
            }
            
            let peopleResponse = try JSONDecoder().decode(PeopleResponse.self, from: data)
            
            if let nextPage = peopleResponse.next {
                self.url = nextPage
                print(nextPage)
            } else {
                hasMorePages = false
            }
                
            return peopleResponse.results
            
        } catch {
            throw URLError(.unknown)
        }
    }
    
    var url = "https://swapi.dev/api/people/?page=1"
    var hasMorePages = true
    
    func resetCollection() {
        self.url = "https://swapi.dev/api/people/?page=1"
    }
}

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

struct Reachability {
    static let networkAvailable = true
}

class DataService: PeopleLoaderProtocol {
    let apiLoader: ApiLoader
    let dbLoader: DBLoader
    var hasMorePages: Bool
    
    init(apiLoader: ApiLoader, dbLoader: DBLoader, hasMorePages: Bool) {
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
