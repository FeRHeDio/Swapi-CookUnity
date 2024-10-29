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

struct Reachability {
    static let networkAvailable = true
}
