//
//  GameList.swift
//  gameLobby
//
//  Created by Frederick Mo on 2022/5/19.
//

import SwiftUI

struct GameList: View {
    var games: [Game]
    
    var body: some View {
        VStack {
            HStack {
                Text("\(games.count) \(games.count > 1 ? "games" : "game")")
                    .font(.headline)
                    .fontWeight(.medium)
                    .opacity(0.7)
                
                Spacer()
            }
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 160), spacing: 15)]) {
                ForEach(games) { game in
                    NavigationLink(destination: GameView(game: game)) {
                            GameCard(game: game)
                        }
                    
                }
            }
            .padding(.top)
        }
        .padding(.horizontal)
    }
}

struct GameList_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            GameList(games: Game.all)
        }
    }
}
