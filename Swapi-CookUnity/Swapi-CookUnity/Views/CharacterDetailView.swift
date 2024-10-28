//
//  CharacterDetailView.swift
//  Swapi-CookUnity
//
//  Created by Fernando Putallaz on 28/10/2024.
//

import SwiftUI

struct CharacterDetailView: View {
    let character: People
    
    init(character: People) {
        self.character = character
    }
    
    var body: some View {
        VStack {
            Image(systemName: "person")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 350)
        }
        
        VStack {
            Divider()
                
            Text(character.name.uppercased())
                .font(.largeTitle)
                .bold()
            
            Divider()
                
            Text(character.homeworld)
                .font(.title3)
        }
        
    }
}

#Preview {
    CharacterDetailView(
        character: People(
            name: "Luke Skywalker",
            height: "1,65",
            mass: "65",
            hairColor: "Brown",
            skinColor: "White",
            eyeColor: "Blue",
            birthYear: "57BBY",
            gender: "Male",
            homeworld: "Tatooine",
            films: ["Phantom Menace"],
            species: [],
            vehicles: [],
            starships: [],
            created: "2014-12-10T15:59:50.509000Z",
            edited: "2014-12-20T21:17:50.323000Z",
            url: "https://swapi.dev/api/people/9/"
        )
    )
}
