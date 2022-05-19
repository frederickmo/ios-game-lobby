//
//  ProfileView.swift
//  gameLobby
//
//  Created by Frederick Mo on 2022/5/19.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationView {
            Text("Profile View")
                .padding()
                .navigationTitle("个人中心")
        }
        .navigationViewStyle(.stack)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
