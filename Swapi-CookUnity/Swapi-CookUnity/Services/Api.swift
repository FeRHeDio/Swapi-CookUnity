//
//  Api.swift
//  Swapi-CookUnity
//
//  Created by Fernando Putallaz on 25/10/2024.
//

import Foundation

class Api {
    var url = "https://swapi.dev/api/people/?page=1"
    var hasMorePages = true
    
    func fetchPeople() async throws -> [People] {
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
    
    func resetURL() {
        self.url = "https://swapi.dev/api/people/?page=1"
    }
}
