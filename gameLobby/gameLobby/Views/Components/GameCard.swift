//
//  GameCard.swift
//  gameLobby
//
//  Created by Frederick Mo on 2022/5/19.
//

import SwiftUI

struct GameCard: View {
    var game: Game
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: game.previewImage)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    
                    .overlay(alignment: .bottom) {
                        LinearGradient(colors: [Color.black.opacity(0.0), Color.black.opacity(0.8)], startPoint: .center, endPoint: .bottom)
                    }
                    .overlay(alignment: .bottom) {
                        Text(game.name)
                            .font(.headline)
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 3, x: 0, y: 0)
                            .frame(maxWidth: 116)
                            .padding()
                    }
            } placeholder: {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120, alignment: .center)
                    .foregroundColor(Color.white.opacity(0.7))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .overlay(alignment: .bottom) {
                        Text(game.name)
                            .font(.headline)
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 3, x: 0, y: 0)
                            .frame(maxWidth: 116)
                            .padding()
                    }
            }
        }
        .frame(width: 160, height: 200, alignment: .top)
        .background(LinearGradient(colors: [Color(.gray).opacity(0.3), Color(.gray)], startPoint: .top, endPoint: .bottom))
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color.black.opacity(0.3), radius: 15, x: 0, y: 10)

    }
}

struct GameCard_Previews: PreviewProvider {
    static var previews: some View {
        GameCard(game: Game.all[0])
    }
}

