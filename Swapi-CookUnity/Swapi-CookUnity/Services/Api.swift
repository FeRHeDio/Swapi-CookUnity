//
//  Api.swift
//  Swapi-CookUnity
//
//  Created by Fernando Putallaz on 25/10/2024.
//

import Foundation

class Api {
    let basePeopleURL = "https://swapi.dev/api/people"
    
    func fetchPeople() async throws -> [People] {
        do {
            guard let url = URL(string: basePeopleURL) else {
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
            
            return peopleResponse.results
            
        } catch {
            throw URLError(.unknown)
        }
    }
}
