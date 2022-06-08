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
    @Published var headPortrait: String
    
    init(loggedIn: Bool, token: String, automaticLogin: Bool, headPortrait: String) {
        self.loggedIn = loggedIn
        self.token = token
        self.automaticLogin = automaticLogin
        self.headPortrait = headPortrait
    }
}

struct ContentView: View {
    
    @State var loggedIn: Bool = false
    @State var token: String = ""
    
    @StateObject var globalVariables = GlobalVariables(loggedIn: false, token: "", automaticLogin: false, headPortrait: "https://game-center-headportrait.oss-cn-hangzhou.aliyuncs.com/head%20portrait/frederickmo@163.comheadportrait.jpg")
    
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
