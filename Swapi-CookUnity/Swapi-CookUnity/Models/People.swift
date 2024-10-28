//
//  People.swift
//  Swapi-CookUnity
//
//  Created by Fernando Putallaz on 25/10/2024.
//

import Foundation

struct PeopleResponse: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [People]
}

struct People: Codable, Identifiable, Equatable {
    var id = UUID().uuidString
    let name: String
    let height: String
    let mass: String
    let hairColor: String
    let skinColor: String
    let eyeColor: String
    let birthYear: String
    let gender: String
    let homeworld: String
    let films: [String]
    let species: [String]
    let vehicles: [String]
    let starships: [String]
    let created: String
    let edited: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case name, height, mass, films, species, vehicles, starships, created, edited, url
        case hairColor = "hair_color"
        case skinColor = "skin_color"
        case eyeColor = "eye_color"
        case birthYear = "birth_year"
        case gender, homeworld
    }
}
