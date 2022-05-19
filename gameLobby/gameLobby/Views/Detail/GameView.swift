//
//  GameView.swift
//  gameLobby
//
//  Created by Frederick Mo on 2022/5/19.
//

import SwiftUI

struct GameView: View {
    var game: Game
    
    var body: some View {
        ScrollView {
            AsyncImage(url: URL(string: game.previewImage)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100, alignment: .center)
                    .foregroundColor(Color.white.opacity(0.7))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(width: 300)
            .background(LinearGradient(colors: [Color(.gray).opacity(0.3), Color(.gray)], startPoint: .top, endPoint: .bottom))
            
            VStack(spacing: 30) {
                Text(game.name)
                    .font(.largeTitle)
                    .bold()
                    .multilineTextAlignment(.center)
                
                VStack(alignment: .leading, spacing: 30) {
                    if !game.description.isEmpty {
                        Text(game.description)
                    }
                    
                    if !game.category.isEmpty {
                        VStack(alignment: .leading, spacing: 20) {
                            Text("标签")
                                .font(.headline)
                            
                            HStack {
                                ForEach(game.tags) { tag in
                                    Text("#" + tag.rawValue)
                                }
                            }
                        }
                    }
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal)
        }
        .ignoresSafeArea(.container, edges: .top)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(game: Game.all[0])
    }
}
