//
//  CategoryView.swift
//  gameLobby
//
//  Created by Frederick Mo on 2022/5/19.
//

import SwiftUI

struct CategoryView: View {
    var body: some View {
        NavigationView {
            List {
                ForEach(Category.allCases) { category in
                    NavigationLink {
                        ScrollView {
                            GameList(games: Game.all.filter{ $0.category.contains(category.rawValue) })
                        }
                        .navigationTitle(category.rawValue + "游戏")
                    } label: {
                        Text(category.rawValue)
                            .fontWeight(.medium)
                    }
                    
                }
            }
            .navigationTitle("游戏分类")
        }
        .navigationViewStyle(.stack)
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView()
    }
}
