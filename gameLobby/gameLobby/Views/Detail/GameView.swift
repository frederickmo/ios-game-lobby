//
//  GameView.swift
//  gameLobby
//
//  Created by Frederick Mo on 2022/5/19.
//

import SwiftUI

struct GameView: View {
    var game: Game
    
    @StateObject var viewModel = ViewModel()
    
    @State var rating: Int = 0
    @State var comment: String = ""
    
    @State var comments: [Comment] = [
        Comment(
            content: "一条测试评论一条测试评论一条测试评论一条测试评论一条测试评论一条测试评论一条测试评论一条测试评论一条测试评论",
            sendTime: "2022-5-24",
            rating: 4),
        Comment(content: "第二条测试评论", sendTime: "2022-5-21", rating: 3)
    ]
    
    @State var showCommentComplete = false
    
    var viewController = ViewController()
    
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
                Text(game.displayName)
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
                
                Button {
                    print("前往示例app")
                    viewController.didTapGoToAnotherApp(appPath: game.appPath)
                } label: {
                    Text("前往")
                        .font(.title)
                        
                        .fontWeight(.semibold)
                        .frame(width: 180.0, height: 60)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                        .shadow(color: Color(#colorLiteral(red: 0.7608050108, green: 0.8164883852, blue: 0.9259157777, alpha: 1)), radius: 20, x: 5, y: 5)
                        
                }
                
                VStack {
                    
                    HStack {
                        Text("评论")
                            .font(.largeTitle)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        
                    }
                    .padding(.top, 20)
                    
                    HStack {
                        
                        
                        HStack {
                            
                            ForEach(1...5, id: \.self) { index in
                                Image(systemName: self.starType(index: index, rating: self.rating))
                                    .foregroundColor(.orange)
                                    .onTapGesture {
                                        print("tapped")
                                        self.rating = index
                                    }
                            }
                        }
                        .padding(.bottom, 10)
                    }
                    
                    HStack {
                        
                        TextField("请输入评论内容", text: $comment)
                            .font(.system(size: 20, weight: .regular))
                            .padding(.top, 5)
                            .background(Color(red: 0.98, green: 0.98, blue: 0.98))
                            .cornerRadius(5)
                        
                        Button {
                            
                            let defaults = UserDefaults.standard

                            if let email = defaults.string(forKey: UserDefaultKeys.email), let token = defaults.string(forKey: UserDefaultKeys.token) {
                                viewModel.leaveCommentOnGame(email: email, token: token, content: comment, gameName: game.name, score: self.rating)
                            }
                            
                            self.comments.append(Comment(content: self.comment, sendTime: Comment.getCurrentDate(), rating: self.rating))
                            
                            self.showCommentComplete.toggle()
                            
                            self.comment = ""
                            
                            
                        } label: {
                            Text("提交")
                        }

                    }
                }
                .alert(isPresented: $showCommentComplete) {
                    Alert(title: Text("提示"), message: Text("评论发送成功"), dismissButton: .default(Text("关闭")))
                }
                
                VStack {
                    
                    ForEach(comments) { comment in
                        
                        Text(comment.content)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .cornerRadius(15)
                            .background(.white)
                            .shadow(color: Color(#colorLiteral(red: 0.7608050108, green: 0.8164883852, blue: 0.9259157777, alpha: 0.5)), radius: 20, x: 3, y: 3)
                        
                        
                        HStack {
                            
                            HStack {
                                ForEach(1...5, id: \.self) { index in
                                    Image(systemName: self.starType(index: index, rating: comment.rating))
                                        .foregroundColor(.orange)
                                }
                            }
                            
                            Text(comment.sendTime)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .padding(.trailing, 5)
                        }
                        .padding(.bottom, 30)
                            
                    }
                }

            }
            .padding(.horizontal)
        }
        .ignoresSafeArea(.container, edges: .top)
    }
    
    private func starType(index: Int, rating: Int) -> String {
        return index <= rating ? "star.fill" : "star"
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(game: Game.all[1])
    }
}
