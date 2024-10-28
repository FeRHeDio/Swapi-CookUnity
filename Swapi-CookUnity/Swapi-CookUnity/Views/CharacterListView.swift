//
//  CharacterListView.swift
//  Swapi-CookUnity
//
//  Created by Fernando Putallaz on 26/10/2024.
//

import SwiftUI

struct CharacterListView: View {
    @State private var charactersViewModel: CharactersViewModel
    
    init(charactersViewModel: CharactersViewModel) {
        self.charactersViewModel = charactersViewModel
    }
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(charactersViewModel.people) { character in
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
        await charactersViewModel.loadCharacters()
    }
}


#Preview {
    CharacterListView(
        charactersViewModel: CharactersViewModel(
            api: Api()
        )
    )
}
