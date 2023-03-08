//
//  ViewModel.swift
//  gameLobby
//
//  Created by Frederick Mo on 2022/5/21.
//

import Foundation
import SwiftUI


let baseUrl: String = "http://124.222.82.210:8176"
let registerViaEmail: String = "/user/registerMailVerification"
let register: String = "/user/register"

func print_log<T>(_ message:T, file: String = #file, method: String = #function, line: Int = #line) {
    print("\((file as NSString).lastPathComponent)[\(line)], \(method): \(message)")
 }

struct RegisterViaEmailResponse: Codable, Hashable {
    var msg: String
    var status: String
    static var empty = RegisterViaEmailResponse(msg: "", status: "")
}

struct RegisterByEmailResponse: Decodable {
    var msg: String
    var status: String
}

struct RegisterResultResponse: Decodable {
    var msg: String
    var status: String
}

struct LoginResponse: Decodable {
    var msg: String
    var token: String
    var userName: String
    var headPortrait: String
    var status: String
}

struct LeaveCommentResponse: Decodable {
    var msg: String? = ""
    var status: String? = ""
}

struct LogOutResponse: Decodable {
    var msg: String
    var status: String
}

class ViewModel: ObservableObject {
    
    @Published var registerViaEmailResponse = RegisterViaEmailResponse(msg: "", status: "")
    @Published var registerByEmailResponse = RegisterByEmailResponse(msg: "", status: "")
    
    @Published var registerResultResponse = RegisterResultResponse(msg: "", status: "")
    @Published var loginResponse = LoginResponse(msg: "", token: "", userName: "", headPortrait: "", status: "")
    @Published var logOutResponse = LogOutResponse(msg: "", status: "")
    
    
    @Published var leaveCommentResponse = LeaveCommentResponse(msg: "", status: "")
    
    @EnvironmentObject var globalVariables: GlobalVariables
    
    func registerViaEmail() {
        
//        let parameters: String = "?email=frederickmo@163.com"
        
        guard let url = URL(string: "http://124.222.82.210:8176/user/registerMailVerification?email=frederickmo@163.com") else {
            print("URL解析失敗")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let response = try JSONDecoder().decode(RegisterViaEmailResponse.self, from: data)
                DispatchQueue.main.async {
                    self?.registerViaEmailResponse = response
                }
                
                print("SUCCESS: \(String(describing: self?.registerViaEmailResponse))")
                if (self?.registerViaEmailResponse.msg == "") {
                    print("成功發送")
                } else {
                    print("已發送")
                }
            } catch {
                print("調用API失敗")
                print(error)
            }
        }
        
        task.resume()
    }
    
    func sendVerificationEmail(emailToSend email: String) async -> Bool {
        
        guard let url = URL(string: "http://124.222.82.210:8176/user/registerMailVerification?email=" + email)
        else {
            print("Invalid URL")
            return false
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let decodedResponse = try? JSONDecoder().decode(RegisterByEmailResponse.self, from: data) {
                registerByEmailResponse = decodedResponse
                
                print(registerByEmailResponse.status)
                
                if registerByEmailResponse.status == "OK" {
//                    verificationEmailSuccessfullySent.toggle()
                    print("验证码成功发送")
                    return true
                } else {
                    print("验证码发送失败")
                    return false
                }
            }
        } catch {
            print("Invalid data")
        }
        return false
    }
    
    func registerViaVerificationCode(verificationCode code: String, email: String, name: String, password: String) async -> Bool {
        guard let url = URL(string: "http://124.222.82.210:8176/user/register?code=" + code + "&email=" + email + "&name=" + name + "&password=" + password) else {
            print_log("code: " + code + " email: " + email + " name: " + name + " password: " + password)
            print_log("Invalid Url")
            return false
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let decodedResponse = try? JSONDecoder().decode(RegisterResultResponse.self, from: data) {
                registerResultResponse = decodedResponse
                
                print(registerResultResponse.status)
                
                if registerResultResponse.status == "OK" {
                    
                    
                    print("注册成功")
                    return true
                } else {
                    print("注册失败")
                    return false
                }
            }
        } catch {
            print("网络相应解析错误")
        }
        
        return false
    }
    
    func login(email: String, password: String) async -> Bool {
        guard let url = URL(string: "http://124.222.82.210:8176/user/login?email=" + email + "&password=" + password) else {
            print("登录 - URL解析错误")
            return false
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let decodedResponse = try? JSONDecoder().decode(LoginResponse.self, from: data) {
                loginResponse = decodedResponse
                print(loginResponse.status, loginResponse.token)
                
                if loginResponse.status == "OK" {
                    
                    let defaults = UserDefaults.standard
                    defaults.set(email, forKey: UserDefaultKeys.email)
                    defaults.set(password, forKey: UserDefaultKeys.password)
                    defaults.set(loginResponse.token, forKey: UserDefaultKeys.token)
                    defaults.set(loginResponse.userName, forKey: UserDefaultKeys.name)
                    defaults.set("https://game-center-headportrait.oss-cn-hangzhou.aliyuncs.com/head%20portrait/" + email + "headportrait.jpg", forKey: UserDefaultKeys.headPortrait)
                    
                    defaults.set(true, forKey: UserDefaultKeys.automaticLogin)
                    
//                    globalVariables.automaticLogin = true
                    
                    print("登陆成功")
                    return true
                } else {
                    print("登录失败")
                    return false
                }
            }
        } catch {
            print("登录过程解析错误")
        }
        
        return false
    }
    
    func logOut(email: String, token: String) {
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
                    self.logOutResponse = response
                    
                    print_log("SUCCESS: \(String(describing: self.logOutResponse))")
                    if self.logOutResponse.status == "OK" {
                        print_log("登出成功")
                        
                        UserDefaults.standard.set(false, forKey: UserDefaultKeys.automaticLogin)
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
    
    func leaveCommentOnGame(email: String, token: String, content: String, gameName: String, score: Int) {
        guard let url = URL(string: "http://124.222.82.210:8176/comment/writeComment") else {
            print_log("URL解析失败")
            return
        }
        var request = URLRequest(url: url)
        let scoreStr = String(score)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(email, forHTTPHeaderField: "email")
        request.setValue(token, forHTTPHeaderField: "token")
        let body: [String: AnyHashable] = [
            "description": content,
            "gameName": gameName,
            "score": scoreStr
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print_log("发送请求失败")
                return
            }
            print(response!)
            do {
                let response = try JSONDecoder().decode(LeaveCommentResponse.self, from: data)
                print(response)
                DispatchQueue.main.async {
                    self.leaveCommentResponse = response
                }
                
                print(String(describing: self.leaveCommentResponse))
                if (self.leaveCommentResponse.status == "OK") {
                    print_log("成功發送")
                } else {
                    print_log("发送失败")
                }
            } catch {
                print_log("调用发送评论API失败")
                print_log(error)
            }
        }.resume()
    }
    
    func getComments() {
        
    }
}

struct UserDefaultKeys {
    static let email: String = "email"
    static let password: String = "password"
    static let token: String = "token"
    static let name: String = "name"
    static let headPortrait: String = "headPortrait"
    
    static let automaticLogin: String = "automaticLogin"
}
