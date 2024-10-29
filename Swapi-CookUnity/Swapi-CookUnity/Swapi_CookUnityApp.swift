//
//  Swapi_CookUnityApp.swift
//  Swapi-CookUnity
//
//  Created by Fernando Putallaz on 25/10/2024.
//

import SwiftUI

@main
struct Swapi_CookUnityApp: App {
    let dataLoader = DataService(
        apiLoader: ApiLoader(),
        dbLoader: DBLoader(hasMorePages: true),
        hasMorePages: true
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
