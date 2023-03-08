//
//  GetVerificationCodeBeforeSignUp.swift
//  gameLobby
//
//  注册 - 等待验证码页面

//  Created by Frederick Mo on 2022/5/21.
//

import SwiftUI


struct GetVerificationCodeBeforeSignUpView: View {
    
    @State var email: String = ""
    @State var verificationCode: String = ""
    
    @State var registerByEmailResponse = RegisterByEmailResponse(msg: "not null", status: "")
    
    @StateObject var viewModel = ViewModel()
    
    @State var verificationEmailSuccessfullySent = false
    
    
    var body: some View {
        VStack {
            Text("注册")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .kerning(1.9)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(alignment: .leading, spacing: 8) {
                
                Text("邮箱")
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                    .padding(.top, 25)
                
                TextField("frederickmo@gmail.com", text: $email)
                    .font(.system(size: 20, weight: .semibold))
                    .padding(.top, 5)
                
                Divider()
                
                Text("验证码")
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                    .padding(.top, 25)
                
                HStack {
                    
                    
                    TextField("frederickmo@gmail.com", text: $verificationCode)
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
                
                Button {
                    print("2")
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
    
    func sendVerificationEmail() async {
        guard let url = URL(string: "http://124.222.82.210:8176/user/registerMailVerification?email=" + email)
        else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let decodedResponse = try? JSONDecoder().decode(RegisterByEmailResponse.self, from: data) {
                registerByEmailResponse = decodedResponse
                
                print(registerByEmailResponse.status)
                
                if registerByEmailResponse.status == "OK" {
                    verificationEmailSuccessfullySent.toggle()
                    print("验证码成功发送")
                } else {
                    print("验证码发送失败")
                }
            }
        } catch {
            print("Invalid data")
        }
    }
}

struct GetVerificationCodeBeforeSignUp_Previews: PreviewProvider {
    static var previews: some View {
        GetVerificationCodeBeforeSignUpView()
    }
}
