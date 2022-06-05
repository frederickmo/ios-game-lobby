//
//  LoginView.swift
//  gameLobby
//
//  Created by Frederick Mo on 2022/5/21.
//

import SwiftUI
import ToastUI

struct LoginView: View {
    
    @State var email: String = ""
    @State var password: String = ""
    
    @State var loggedIn: Bool = false
    
    @State var showLoginSuccess: Bool = false
    @State var showLoginFailure: Bool = false
    
    @StateObject var viewModel = ViewModel()
    
    @EnvironmentObject var globalVariables: GlobalVariables
    
    var body: some View {
        VStack {
            Text("登录")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .kerning(1.9)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(alignment: .leading, spacing: 6) {
                
                Text("邮箱")
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                    .padding(.top, 20)
                
                TextField("frederickmo@gmail.com", text: $email)
                    .font(.system(size: 20, weight: .semibold))
                    .padding(.top, 5)
                
                Divider()
                
                Text("密码")
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                    .padding(.top, 20)
                
                SecureField("123456", text: $password)
                    .font(.system(size: 20, weight: .semibold))
                    .padding(.top, 5)
                
                Divider()
                
                Button {
                    print("1")
                } label: {
                    Text("忘记密码？")
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                    
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.top, 10)
                
                Button {
                    Task {
                        let successfullyLoggedIn = await viewModel.login(email: email, password: password)
                        if successfullyLoggedIn {
                            loggedIn.toggle()
                            showLoginSuccess.toggle()
                            globalVariables.loggedIn = true
                            globalVariables.automaticLogin = true
                        } else {
                            showLoginFailure.toggle()
                        }
                    }
                } label: {
                    Image(systemName: "arrow.right")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black)
                        .clipShape(Circle())
                        .shadow(color: Color.blue.opacity(0.6), radius: 5, x: 0, y: 0)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 10)
                
            }
        }
        .padding()
        .toast(isPresented: $showLoginSuccess, dismissAfter: 1.0) {
            ToastView("登录成功")
        }
        .toast(isPresented: $showLoginFailure, dismissAfter: 1.0) {
            ToastView("登录失败")
        }
        

    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
            LoginView()
    }
}
