//
//  CharacterListView.swift
//  Swapi-CookUnity
//
//  Created by Fernando Putallaz on 26/10/2024.
//

import SwiftUI

struct CharacterListView: View {
    @State private var people = [People]()
    
    let api: Api
    
    init(api: Api) {
        self.api = api
    }
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(people) { character in
                    CharacterDetailView(character: character)
                }
            }
        }
        .padding()
        .task {
            try? await getData()
        }
    }
    
    private func getData() async throws {
        do {
            self.people = try await api.fetchPeople()
        } catch {
            // handle error
        }
    }
}


#Preview {
    CharacterListView(api: Api())
}
