//
//  CharactersViewModel.swift
//  Swapi-CookUnity
//
//  Created by Fernando Putallaz on 28/10/2024.
//

import Foundation


@MainActor
@Observable
class CharactersViewModel {
    var people = [People]()
    
    let api: Api
    
    init(api: Api) {
        self.api = api
        
        Task {
            await loadFirstCharacters()
        }
    }
    
    func loadFirstCharacters() async {
        do {
            self.people.removeAll()
            self.people = try await api.fetchPeople()
        } catch {
            // handle error
        }
    }
    
    func loadMoreCharacters() async {
        if api.hasMorePages {
            do {
                let morePeople = try await api.fetchPeople()
                self.people.append(contentsOf: morePeople)
            } catch {
                // handle error
            }
        }
    }
}
