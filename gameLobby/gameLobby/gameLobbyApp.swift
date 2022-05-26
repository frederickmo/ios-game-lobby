//
//  gameLobbyApp.swift
//  gameLobby
//
//  Created by Frederick Mo on 2022/5/19.
//

import SwiftUI

@main
struct gameLobbyApp: App {
    
    @EnvironmentObject var globalVariables: GlobalVariables
    @StateObject var viewModel = ViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
