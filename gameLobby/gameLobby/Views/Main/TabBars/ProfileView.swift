//
//  ProfileView.swift
//  gameLobby
//
//  Created by Frederick Mo on 2022/5/19.
//

import SwiftUI
import OSLog

struct ProfileView: View {
    
    var basicAvatarUrl = "https://game-center-headportrait.oss-cn-hangzhou.aliyuncs.com/head portrait/frederickmo@163.comheadportrait.png"
    
    var logger = Logger()
    
    @State private var showUploadHandleImageType: Bool = false
    @State private var showImagePicker: Bool = false
    
    @State private var showLoggedOut: Bool = false
    
    @State private var imagePickerSourceType: UIImagePickerController.SourceType = .photoLibrary
    
    @StateObject var userDataViewModel = UserDataViewModel()
    @StateObject var viewModel = ViewModel()
    
    @EnvironmentObject var globalVariables: GlobalVariables
    
    var body: some View {
        NavigationView {
            ScrollView {
                
                VStack {
                    
                    HStack {
                        
                        VStack {
                            Text(self.getName())
                                .font(.title)
                                .bold()
                            .frame(width: 200, alignment: .leading)
                            
                            Text(UserDefaults.standard.string(forKey: UserDefaultKeys.email) ?? "未知")
                                .frame(width: 200, alignment: .leading)
                                .foregroundColor(.gray)
                                .padding(.top, 2)
                            
                            Button {
                                print("退出登录")
                                
                                let defaults = UserDefaults.standard
                                if let email = defaults.string(forKey: UserDefaultKeys.email), let token = defaults.string(forKey: UserDefaultKeys.token) {
                                    print("退出登录：email: " + email + " token: " + token)
//                                    Task {
//                                        let logOutResult = await viewModel.logOut(email: email, token: token)
//                                        print("logOutResult: ", logOutResult)
//                                        if logOutResult {
//                                            self.showLoggedOut.toggle()
//                                            globalVariables.loggedIn = false
//                                        }
//                                    }
//                                    viewModel.logOut(email: email, token: token)
                                    
                                    guard let url = URL(string: "http://124.222.82.210:8176/user/logOut?email=" + email + "&token=" + token) else {
                                        print_log("登出 - URL解析错误")
                                        return
                                    }
                                    
                                    var request = URLRequest(url: url)
                                    request.httpMethod = "GET"
                                    request.setValue(email, forHTTPHeaderField: "email")
                                    request.setValue(token, forHTTPHeaderField: "token")
                                    
                                    
                                    let task = URLSession.shared.dataTask(with: request) { data, _, error in
                                        guard let data = data, error == nil else {
                                            print_log("请求发送失败")
                                            return
                                        }
                                        
                                        do {
                                            let response = try JSONDecoder().decode(LogOutResponse.self, from: data)
                                            DispatchQueue.main.async { [self] in
                                                viewModel.logOutResponse = response
                                                
                                                print_log("SUCCESS: \(String(describing: viewModel.logOutResponse))")
                                                if viewModel.logOutResponse.status == "OK" {
                                                    print_log("登出成功")
                                                    
                                                    UserDefaults.standard.set(false, forKey: UserDefaultKeys.automaticLogin)
                                                    globalVariables.automaticLogin = false
                                                    globalVariables.loggedIn = false
                                                    
                                                    self.showLoggedOut.toggle()
                                                    
                                                } else {
                                                    print_log("登出失败")
                                                }
                                            }
                                            
                                            
                                        } catch {
                                            print_log("调用登出api失败")
                                            print(error)
                                        }
                                    }
                                    
                                    task.resume()
                                    
                                    
                                }
                                
                            } label: {
                                Text("退出登录")
                            }
                            .frame(width: 200, alignment: .leading)
                            .padding(.top, 8)

                        }
                        
                        
                        
                        VStack {
                            
                            Button {
                                print_log("button")
                                
                                showUploadHandleImageType.toggle()
                                
                            } label: {
                                Image("defaultAvatar")
                                    .resizable()
                                    .scaledToFit()
                            }
                            .frame(width: 120, height: 120, alignment: .trailing)
                            
                        }
                        .frame(width: 120, height: 120, alignment: .trailing)
                        .background(LinearGradient(colors: [Color(.gray).opacity(0.3), Color(.gray)], startPoint: .top, endPoint: .bottom))
                        .clipShape(Circle())
                        .shadow(color: Color.black.opacity(0.3), radius: 15, x: 0, y: 10)
                    }
                    .padding(.top, 40)
                    
                    VStack {
                        
                        Text("我的游戏")
                            .font(.largeTitle)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 10)
                        
                        GameList(games: Game.myGame)
                    }
                    .frame(maxWidth: .infinity)
                    
                    Spacer()
                    
                    
                }
                .alert(isPresented: $showLoggedOut) {
                    Alert(title: Text("提示"), message: Text("成功退出登录"), dismissButton: .default(Text("关闭")))
            }
            .navigationTitle("个人中心")
            .confirmationDialog("更改头像", isPresented: $showUploadHandleImageType) {
                Button("从相册") {
                    print_log("打开相册")
                    logger.log("打开相册")
                    imagePickerSourceType = .photoLibrary
                    showImagePicker.toggle()
                }
                
                Button("从相机") {
                    print_log("打开相机")
                    imagePickerSourceType = .camera
                    showImagePicker.toggle()
                }
            }
            
        }
        .navigationViewStyle(.stack)
        .sheet(isPresented: $showImagePicker, content: {
            ImagePicker(sourceType: .photoLibrary) { image in
                print_log(image)
                print_log(image.size)
                
                let defaults = UserDefaults.standard
                
                if let email = defaults.string(forKey: UserDefaultKeys.email), let token = defaults.string(forKey: UserDefaultKeys.token) {
                    userDataViewModel.uploadImage(email: email, token: token, image: image)
                } else {
                    print_log("未获取到本地email和token")
                }
                
                
            }
        })
    }
    }
                        
    func getName() -> String {
        let defaults = UserDefaults.standard
        if let value = defaults.string(forKey: UserDefaultKeys.name) {
            return value
        } else {
            return "未知"
        }
    }
    
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

