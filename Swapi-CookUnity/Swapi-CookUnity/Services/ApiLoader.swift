//
//  ApiLoader.swift
//  Swapi-CookUnity
//
//  Created by Fernando Putallaz on 29/10/2024.
//

import Foundation

class ApiLoader: PeopleLoaderProtocol {
    private var session: URLSession
    var url = "https://swapi.dev/api/people/?page=1"
    var hasMorePages = true
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func getPeople() async throws -> [People] {
        do {
            guard let url = URL(string: url) else {
                throw URLError(.badURL)
            }
            
            let (data, response) = try await session.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw URLError(.badServerResponse)
            }
            
            guard httpResponse.statusCode == 200 else {
                throw URLError(.badServerResponse)
            }
            
            let peopleResponse = try JSONDecoder().decode(PeopleResponse.self, from: data)
            
            if let nextPage = peopleResponse.next {
                self.url = nextPage
                print("Next Page: \(nextPage)")
            } else {
                hasMorePages = false
                print("No more pages to load.")
            }
            
            return peopleResponse.results
            
        } catch {
            throw URLError(.unknown)
        }
    }
    
    func resetCollection() {
        self.url = "https://swapi.dev/api/people/?page=1"
    }
}
