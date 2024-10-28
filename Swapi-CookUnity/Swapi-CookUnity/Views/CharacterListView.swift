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
        VStack {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(people) { character in
                        CharacterCardView(character: character)
                            .padding(.horizontal, 12)
                    }
                }
            }
        }
        .task {
            await getData()
        }
    }
    
    private func getData() async {
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
