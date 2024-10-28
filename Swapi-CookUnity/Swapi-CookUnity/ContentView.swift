//
//  ContentView.swift
//  Swapi-CookUnity
//
//  Created by Fernando Putallaz on 25/10/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var people = [People]()
    
    let api: Api
    
    init(api: Api) {
        self.api = api
    }
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(people) { character in
                    Text("Name: \(character.name)")
                    Text("Name: \(character.birthYear)")
                    Text("Name: \(character.eyeColor)")
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
    ContentView(api: Api())
}