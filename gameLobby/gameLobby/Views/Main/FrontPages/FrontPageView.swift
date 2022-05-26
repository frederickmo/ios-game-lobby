//
//  FrontPageView.swift
//  gameLobby
//
//  Created by Frederick Mo on 2022/5/21.
//

import SwiftUI


struct FrontPageView: View {
    
    @State var maxCircleHeight: CGFloat = 0
    
    @State var showSignUp: Bool = false
    
    @State var showSendVerificationEmail: Bool = true
    
    @StateObject var viewModel = ViewModel()
    
    @EnvironmentObject var globalVariables: GlobalVariables
    
    var body: some View {
        VStack {
            
            GeometryReader { proxy -> AnyView in
                
                let height = proxy.frame(in: .global).height
                
                DispatchQueue.main.async {
                    if maxCircleHeight == 0 {
                        maxCircleHeight = height
                    }
                }
                
                return AnyView(
                    
                    ZStack {
                        Circle()
                            .fill(Color.black)
                            .offset(x: getRect().width / 2, y: -height / 1.3)
                        Circle()
                            .fill(Color.black)
                            .offset(x: -getRect().width / 2, y: -height / 1.5)
                        Circle()
                            .fill(Color.blue)
                            .offset(y: -height / 1.3)
                            .rotationEffect(.init(degrees:  -5))
                    }
                )
            }
            .frame(maxHeight: getRect().width * 0.8)
            
            ZStack {
                
                if showSignUp {
                    SignUpView()
                        .transition(.slide)
                } else {
                    LoginView()
                        .transition(.slide)
                        .onAppear {
                            
                            globalVariables.automaticLogin = UserDefaults.standard.bool(forKey: UserDefaultKeys.automaticLogin)
                            
                            print_log("是否自动登录：")
                            print(globalVariables.automaticLogin)
                            if globalVariables.automaticLogin {
                                let defaults = UserDefaults.standard
                                
                                if let email = defaults.string(forKey: UserDefaultKeys.email), let password = defaults.string(forKey: UserDefaultKeys.password) {
                                    print("本地存储的email: " + email + " password: " + password)
                                    
                                    Task {
                                        let loginResult = await viewModel.login(email: email, password: password)
                                        if loginResult {
                                            globalVariables.loggedIn = true
                                        } else {
                                            globalVariables.loggedIn = false
                                        }
                                    }
                                    
                                    
                                } else {
                                    print("ERROR: 读取本地存储失败")
                                }
                            }
                            
                        }
                }
            }
            .padding(.top, -maxCircleHeight / (getRect().height < 750 ? 1.5 : 1.6))
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .overlay (
            HStack {
                Text(showSignUp ? "已注册？" : "还未注册？")
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                
                Button {
                    withAnimation {
                        showSignUp.toggle()
                    }
                } label: {
                    Text(showSignUp ? "去登录" : "去注册")
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                }
            }
                .padding(.bottom, getSafeArea().bottom == 0 ? 15 : 0)
            , alignment: .bottom
        )
        .background(
            HStack {
                Circle()
                    .fill(.blue)
                    .frame(width: 70, height: 70)
                    .offset(x: -30, y: getRect().height < 750 ? 10 : 0)
                
                Spacer(minLength: 0)
                
                Circle()
                    .fill(.black)
                    .frame(width: 110, height: 110)
                    .offset(x: 40, y: 20)
            }
                .offset(y: getSafeArea().bottom + 30)
            , alignment: .bottom
        )
    }
}


struct FrontPageView_Previews: PreviewProvider {
    static var previews: some View {
        FrontPageView()
    }
}

extension View {
    
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
    
    func getSafeArea() -> UIEdgeInsets {
//        return UIApplication.shared.windows.first?.safeAreaInsets ?? UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return UIApplication.shared.windows.first?.safeAreaInsets ?? UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
