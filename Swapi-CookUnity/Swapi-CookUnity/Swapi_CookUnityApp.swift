//
//  Swapi_CookUnityApp.swift
//  Swapi-CookUnity
//
//  Created by Fernando Putallaz on 25/10/2024.
//

import SwiftUI

@main
struct Swapi_CookUnityApp: App {
    let dataLoader = DataLoader(
        apiLoader: ApiLoader(),
        dbLoader: DBLoader()
    )
    
    var body: some Scene {
        WindowGroup {
            CharacterListView(
                charactersViewModel: CharactersViewModel(
                    loader: dataLoader
                )
            )
        }
    }
}
