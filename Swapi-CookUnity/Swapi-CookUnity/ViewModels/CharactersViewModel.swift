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
    var hasMorePages = true
    
    let loader: PeopleLoaderProtocol
    
    init(loader: PeopleLoaderProtocol) {
        self.loader = loader
        
        Task {
            await loadFirstCharacters()
        }
    }
    
    func loadFirstCharacters() async {
        do {
            self.people.removeAll()
            loader.resetCollection()
            self.people = try await loader.getPeople()
        } catch {
            // handle error
        }
    }
    
    func loadMoreCharacters() async {
        if loader.hasMorePages {
            do {
                let morePeople = try await loader.getPeople()
                self.people.append(contentsOf: morePeople)
            } catch {
                // handle error
            }
        } else {
            hasMorePages = false
        }
    }
}

