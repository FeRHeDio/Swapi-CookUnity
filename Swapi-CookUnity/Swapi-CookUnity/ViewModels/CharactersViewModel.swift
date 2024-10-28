//
//  CharactersViewModel.swift
//  Swapi-CookUnity
//
//  Created by Fernando Putallaz on 28/10/2024.
//

import Foundation

@Observable
class CharactersViewModel {
    var people = [People]()
    
    let api: Api
    
    init(api: Api) {
        self.api = api
    }
    
    func loadCharacters() async {
        do {
            self.people = try await api.fetchPeople()
        } catch {
            // handle error
        }
    }
}
