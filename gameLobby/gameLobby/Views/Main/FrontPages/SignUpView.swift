//
//  SignUpView.swift
//  gameLobby
//
//  Created by Frederick Mo on 2022/5/21.
//

import SwiftUI

struct SignUpView: View {
    
    @State var email: String = UserDefaults.standard.string(forKey: UserDefaultKeys.email) ?? ""
    @State var password: String = UserDefaults.standard.string(forKey: UserDefaultKeys.password) ?? ""
    @State var confirmPassword: String = ""
    @State var name: String = ""
    @State var verificationCode: String = ""
    
    @State var registerByEmailResponse = RegisterByEmailResponse(msg: "not null", status: "")
    
    @StateObject var viewModel = ViewModel()
    
    @State var verificationEmailSuccessfullySent = false
    
    @State var loggedIn = false
    
    @EnvironmentObject var globalVariables: GlobalVariables
    
    var body: some View {
        VStack {
            Text("注册")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .kerning(1.9)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(alignment: .leading, spacing: 6) {
                
                
                Group {
                    
                    Text("邮箱")
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                    .padding(.top, 20)
                    
                    TextField("frederickmo@gmail.com", text: $email)
                        .font(.system(size: 20, weight: .semibold))
                        .padding(.top, 5)
                    
                    Divider()
                }
                
                Group {
                    
                    Text("用户名")
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                    .padding(.top, 20)
                    
                    TextField("John Doe", text: $name)
                        .font(.system(size: 20, weight: .semibold))
                        .padding(.top, 5)
                    
                    Divider()
                }
                
                Group {
                    
                    Text("验证码")
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                        .padding(.top, 20)
                    
                    HStack {
                        
                        TextField("", text: $verificationCode)
                            .font(.system(size: 20, weight: .semibold))
                            .padding(.top, 5)

                        Button {
                            Task {
                                let success = await viewModel.sendVerificationEmail(emailToSend: email)
                                if success {
                                    verificationEmailSuccessfullySent.toggle()
                                }
                            }
                        } label: {
                            Text(verificationEmailSuccessfullySent ? "验证码已发送" : "获取验证码")
                                .fontWeight(.bold)
                                .foregroundColor(verificationEmailSuccessfullySent ? .gray : .blue)
                        }
                        .disabled(verificationEmailSuccessfullySent)

                    }
                
                    Divider()
                }
                
                Group {
                    
                    Text("密码")
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                        .padding(.top, 20)
                    
                    SecureField("", text: $password)
                        .font(.system(size: 20, weight: .semibold))
                        .padding(.top, 5)
                    
                    Divider()
                    
                }
                
                Group {
                    
                    Text("确认密码")
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                        .padding(.top, 20)
                    
                    SecureField("", text: $confirmPassword)
                        .font(.system(size: 20, weight: .semibold))
                        .padding(.top, 5)
                    
                    Divider()
                    
                }
                
                Button {
                    Task {
                        let successfullyRegister = await viewModel.registerViaVerificationCode(verificationCode: verificationCode, email: email, name: name, password: password)
                        
                        if successfullyRegister {
                            let successfullyLogin = await viewModel.login(email: email, password: password)
                            
                            if successfullyLogin {
                                loggedIn.toggle()
                                globalVariables.loggedIn = true
                                globalVariables.automaticLogin = true
                            }
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
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
