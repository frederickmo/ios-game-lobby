//
//  GameView.swift
//  gameLobby
//
//  Created by Frederick Mo on 2022/5/19.
//

import SwiftUI
import ToastUI

struct GameView: View {
    var game: Game
    
    @StateObject var viewModel = ViewModel()
    
    @State var rating: Int = 0
    @State var comment: String = ""
    
    @State var averageScore: Int = 0
    
    @State var showSuccessComment: Bool = false
    @State var showFailureComment: Bool = false
    
    @State var comments: [Comment] = []
    
    @State var showCommentComplete: Bool = false
    
    @State var hasComments: Bool = true
    
    
    
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
                            
                            addComment(description: comment, gameName: game.name, rating: rating)
                            
//                            let defaults = UserDefaults.standard
//
//                            if let email = defaults.string(forKey: UserDefaultKeys.email), let token = defaults.string(forKey: UserDefaultKeys.token) {
//                                viewModel.leaveCommentOnGame(email: email, token: token, content: comment, gameName: game.name, score: self.rating)
//                            }
                            
//                            self.comments.append(Comment(content: self.comment, sendTime: Comment.getCurrentDate(), rating: self.rating))
                            
                            self.comment = ""
                            
                            
                        } label: {
                            Text("提交")
                        }

                    }
                }
                .toast(isPresented: $showSuccessComment, dismissAfter: 1.0) {
                    ToastView("评论发送成功")
                }
                
                VStack {
                    
                    HStack(alignment: .center) {
                        
                        Text("平均评分")
                            .font(.headline)
                            .padding(.bottom, 10.0)
                            
                        
                        HStack {
                            
                            ForEach(1...5, id: \.self) { index in
                                Image(systemName: self.starType(index: index, rating: self.averageScore))
                                    .foregroundColor(.orange)
                            }
                        }
                        .padding(.bottom, 10)
                        
                        Spacer()
                    }
                    
                    if hasComments {
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
                                    Text(comment.userName)
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                        .padding(.trailing, 5)
                                }
                                .padding(.bottom, 30)
                            }
                        }
                    } else {
                        Text("暂无评论")
                    }
                }
                .onAppear {
                    getAllComments(gameName: game.name)
                }
                .refreshable(action: {
                    addComment(description: comment, gameName: game.name, rating: rating)
                })

            }
            .padding(.horizontal)
        }
        .ignoresSafeArea(.container, edges: .top)
    }
    
    private func starType(index: Int, rating: Int) -> String {
        return index <= rating ? "star.fill" : "star"
    }
    
    func addComment(description: String, gameName: String, rating: Int) {
        let email = UserDefaults.standard.string(forKey: UserDefaultKeys.email)
        let token = UserDefaults.standard.string(forKey: UserDefaultKeys.token)
//        let description = "好评来自美国"
        let encodedDescription = description.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        print_log("encodedDescription: " + encodedDescription!)
        if let decodedDescription = encodedDescription?.removingPercentEncoding {
            print("decodedDescription: " + decodedDescription)
        }
//        let gameName = "MikuDance"
//        let score = "5"
        guard let url = URL(string: "http://124.222.82.210:8176/comment/writeComment?description=" + encodedDescription! + "&gameName=" + gameName + "&score=" + String(rating)) else {
            print_log("评论 - URL解析错误")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(email, forHTTPHeaderField: "email")
        request.setValue(token, forHTTPHeaderField: "token")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print_log("请求发送失败")
                return
            }
    //        print_log("RESPONSE")
    //        print(response ?? "response is nil")
            
            do {
                let response = try JSONDecoder().decode(LeaveCommentResponse.self, from: data)
                DispatchQueue.main.async {
                    print_log("SUCCESS: \(String(describing: response))")
                    if response.status == "OK" {
                        print_log("评论发送成功")
                        showSuccessComment.toggle()
                    } else {
                        print_log("评论发送失败")
                        showFailureComment.toggle()
                    }
                }
            } catch {
                print_log("调用评论api失败")
                showFailureComment.toggle()
                print(error)
            }
        }.resume()
    }
    
    func getAllComments(gameName: String) {
        let email = UserDefaults.standard.string(forKey: UserDefaultKeys.email)
        let token = UserDefaults.standard.string(forKey: UserDefaultKeys.token)
        
        guard let url = URL(string: "http://124.222.82.210:8176/comment/searchGameComment?gameName=" + gameName) else {
            print_log("评论 - URL解析错误")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(email, forHTTPHeaderField: "email")
        request.setValue(token, forHTTPHeaderField: "token")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print_log("请求发送失败")
                return
            }
            print_log("RESPONSE")
            print(response ?? "response is nil")
            
            do {
                let commentListReponse = try JSONDecoder().decode(CommentList.self, from: data)
                DispatchQueue.main.async {
                    
                    print(commentListReponse)
                    
                    print_log("SUCCESS: \(String(describing: commentListReponse))")
                    if commentListReponse.status == "OK" {
                        print_log("评论获取成功")
                        let comments = commentListReponse.comments
                        self.averageScore = Int(commentListReponse.averageScore)
                        comments.forEach { commentItem in
                            let comment = Comment(userName: commentItem.userName, content: commentItem.description, rating: commentItem.score)
                            self.comments.append(comment)
                        }
//                        comments.forEach { comment in
//                            print("comment的类型", type(of: comment))
//                            print("评论内容 " + comment.description)
//                            print("评分 " + String(comment.score))
//                        }
                    } else {
                        print_log("评论获取失败")
                    }
                }
            } catch {
                print_log("调用评论api失败")
                self.hasComments = false
                print(error)
            }
        }.resume()
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(game: Game.all[1])
    }
}
