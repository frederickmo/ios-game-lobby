//
//  ProfileView.swift
//  gameLobby
//

//  个人信息页面

//  Created by Frederick Mo on 2022/5/19.
//

import SwiftUI
import OSLog
import Alamofire
import ToastUI

struct ProfileView: View {
    
    var basicAvatarUrl = "https://game-center-headportrait.oss-cn-hangzhou.aliyuncs.com/head portrait/frederickmo@163.comheadportrait.png"
    
    var logger = Logger()
    
    @State private var showUploadHandleImageType: Bool = false
    @State private var showImagePicker: Bool = false
    
    @State private var showLoggedOut: Bool = false
    
    @State private var imagePickerSourceType: UIImagePickerController.SourceType = .photoLibrary
    
    @StateObject var userDataViewModel = UserDataViewModel()
    @StateObject var viewModel = ViewModel()
    
    @State private var asyncImageUrl: String = "https://game-center-headportrait.oss-cn-hangzhou.aliyuncs.com/head%20portrait/" + UserDefaults.standard.string(forKey: UserDefaultKeys.email)! + "headportrait.jpg"
    
    @State private var showSuccessToast: Bool = false
    @State private var showFailureToast: Bool = false
    @State private var showLogOutToast: Bool = false
    
    @State private var avatarButtonDisable: Bool = false
    
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
                                                    self.showLogOutToast.toggle()
                                                    
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
                            .toast(isPresented: $showLogOutToast, dismissAfter: 1.0) {
                                ToastView("已退出")
                            }


                        }
                        
                        
                        
                        VStack {
                            
                            Button {
                                print_log("button")
                                
                                showUploadHandleImageType.toggle()
                                
                            } label: {
                                AsyncImage(url: URL(string: asyncImageUrl))  { phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView()
                                            .frame(width: 120, height: 120)
                                    case .success(let image):
                                        image.resizable()
                                             .aspectRatio(contentMode: .fill)
                                             .frame(maxWidth: 300, maxHeight: 100)
                                    case .failure:
                                        Image(systemName: "photo")
                                            .scaledToFit()
                                            .frame(width: 120, height: 120)
                                    @unknown default:
                                        // Since the AsyncImagePhase enum isn't frozen,
                                        // we need to add this currently unused fallback
                                        // to handle any new cases that might be added
                                        // in the future:
                                        EmptyView()
                                    }
                                }
                                .accentColor(showSuccessToast ? .black : .black)
                                .refreshable {
                                    showSuccessToast.toggle()
                                }
                            }
                            .frame(width: 120, height: 120, alignment: .trailing)
                            .disabled(avatarButtonDisable)
                            
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
                    uploadImage(image: image.pngData()!, email: email, token: token)
                } else {
                    print_log("未获取到本地email和token")
                }
            }
        })
        .toast(isPresented: $showSuccessToast, dismissAfter: 1.0) {
            ToastView("上传成功")
        }
        .toast(isPresented: $showFailureToast, dismissAfter: 1.0) {
            ToastView("上传失败")
        }


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
    
    func uploadImage(image: Data, email: String ,token: String)
        {
            asyncImageUrl = ""
            avatarButtonDisable = true
            //Parameter HERE
    //        let parameters = [
    //            "id": "429",
    //            "docsFor" : "visitplan"
    //        ]
            //Header HERE
            let headers: HTTPHeaders = [
//                "email": email,
//                "token" : token,
                "Content-type": "multipart/form-data",
                "Content-Disposition" : "form-data"
            ]
            
            let imgData = image
            
            AF.upload(multipartFormData: { multipartFormData in
                //Parameter for Upload files
                multipartFormData.append(imgData, withName: "files",fileName: "furkan.png" , mimeType: "image/png")
    //            for (key, value) in parameters
    //            {
    //                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
    //            }
            },
               to: "http://localhost:8000/multipleFiles", //URL Here
              usingThreshold:UInt64.init(),
                method: .post,
                headers: headers //pass header dictionary here
            ).responseJSON(completionHandler: { data in
                switch data.result {
                case .success(let result):
                    print(type(of: result))
                    print_log("SUCCESS")
                    print(result)
                    // 这是一个黑科技：先用refreshable()修饰符跟踪bool变量的toggle()方法，
                    // 再更新url就可以达到更新目的
                    showSuccessToast.toggle()
//                    asyncImageUrl = "https://game-center-headportrait.oss-cn-hangzhou.aliyuncs.com/head%20portrait/" + UserDefaults.standard.string(forKey: UserDefaultKeys.email)! + "headportrait.jpg"
//                    print_log("current asyncImageUrl: " + asyncImageUrl)
//                    print_log("UserDefaults的headPortrait: " + UserDefaults.standard.string(forKey: UserDefaultKeys.headPortrait)!)
                    avatarButtonDisable = false
                case .failure(let error):
                    print_log("ERROR")
                    print(error)
                    showFailureToast.toggle()
                }
            })
        }
    
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

