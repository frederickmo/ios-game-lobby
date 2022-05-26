//
//  ContentView.swift
//  gameLobby
//
//  Created by Frederick Mo on 2022/5/19.
//

import SwiftUI

class GlobalVariables : ObservableObject {
    @Published var loggedIn: Bool
    @Published var token: String
    @Published var automaticLogin: Bool
    
    init(loggedIn: Bool, token: String, automaticLogin: Bool) {
        self.loggedIn = loggedIn
        self.token = token
        self.automaticLogin = automaticLogin
    }
}

struct ContentView: View {
    
    @State var loggedIn: Bool = false
    @State var token: String = ""
    
    @StateObject var globalVariables = GlobalVariables(loggedIn: false, token: "", automaticLogin: false)
    
    var body: some View {
//        TabBar()
        if !globalVariables.loggedIn {
            FrontPageView()
            .environmentObject(globalVariables)
        } else {
            TabBar()
            .environmentObject(globalVariables)
        }
            
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
