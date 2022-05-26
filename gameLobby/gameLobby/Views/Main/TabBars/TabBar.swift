//
//  TabBar.swift
//  gameLobby
//
//  Created by Frederick Mo on 2022/5/19.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("大厅", systemImage: "house")
                }
            
            CategoryView()
                .tabItem {
                    Label("分类", systemImage: "square.fill.text.grid.1x2")
                }
            
            MessageView()
                .tabItem{
                    Label("消息", systemImage: "message")
                }
            
            ProfileView()
                .tabItem {
                    Label("个人", systemImage: "person")
                }
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
