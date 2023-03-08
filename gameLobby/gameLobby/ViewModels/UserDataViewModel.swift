//
//  UserDataViewModel.swift
//  gameLobby

// 控制图片上传功能的viewModel
//
//  Created by Frederick Mo on 2022/5/24.
//

import Foundation
import UIKit
import SwiftUI
import Combine

struct UploadImageResponse: Decodable {
    
    var msg: String
    var url: String
    var status: String
}

class UserDataViewModel: ObservableObject {
    
    // 上传的图片
    @Published var selectedHandleImage: UIImage?
    
    // 控制图片上传的alert是否显示
    @Published var showSelectedImageType: Bool = false
    
    // 图片选择器的显示和隐藏
    @Published var showImagePicker: Bool = false
    
    // 从相册还是相机选择图片
    @Published var photoSource: UIImagePickerController.SourceType = .photoLibrary
    
    
    private var cancellable: Set<AnyCancellable> = []
    
    // selectedHandleImage值改变后调用

    func uploadImage(email: String, token: String, image: UIImage) {
        let url = URL(string: "http://124.222.82.210:8176/user/uploadHeadPortrait")
        
        let fileName = "avatar.png"

        // generate boundary string using a unique per-app string
        let boundary = UUID().uuidString

        let session = URLSession.shared
//        let config = URLSessionConfiguration.default
//        let session = URLSession(configuration: config)

        // Set the URLRequest to POST and to the specified URL
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "POST"

        // Set Content-Type Header to multipart/form-data, this is equivalent to submitting form data with file upload in a web browser
        // And the boundary is also set here
        urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue(UserDefaults.standard.string(forKey: UserDefaultKeys.email)!, forHTTPHeaderField: "email")
        urlRequest.addValue(UserDefaults.standard.string(forKey: UserDefaultKeys.token)!, forHTTPHeaderField: "token")

        var data = Data()

        // Add the image data to the raw http request data
        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data\r\n".data(using: .utf8)!)
//        data.append("Content-Disposition: form-data; name=\"fileToUpload\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
        data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
        data.append(image.pngData()!)

        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        
        print_log(data)

        // Send a POST request to the URL, with the data we created earlier
        session.uploadTask(with: urlRequest, from: data, completionHandler: { responseData, response, error in
            print_log("uploadTask函数第一行执行")
            print_log("responseData")
            print(responseData!)
            print_log("response")
            print(response!)
            
            if(error != nil){
                    print_log("\(error!.localizedDescription)")
            } else {
                let decodedData = try? JSONSerialization.jsonObject(with: responseData!, options: [])
                print(decodedData!)
            }
                
                guard let responseData = responseData else {
                    print_log("no response data")
                    return
                }
                
                if let responseString = String(data: responseData, encoding: .utf8) {
                    print_log("uploaded to: \(responseString)")
                }
        }).resume()
    }
    
    func saveImage(image: UIImage) {
        let req = NSMutableURLRequest(url: NSURL(string:"http://124.222.82.210:8176/user/uploadHeadPortrait")! as URL)
        let ses = URLSession.shared
        let name = "avatar"
        let token = UserDefaults.standard.string(forKey: UserDefaultKeys.token)
        let email = UserDefaults.standard.string(forKey: UserDefaultKeys.email)
        req.httpMethod="POST"
        req.setValue("application/octet-stream", forHTTPHeaderField: "Content-Type")
        req.addValue(token!, forHTTPHeaderField: "token")
        req.addValue(email!, forHTTPHeaderField: "email")
        req.addValue(name, forHTTPHeaderField: "X-FileName")
        let jpgData = image.jpegData(compressionQuality: 1.0)
        req.httpBodyStream = InputStream(data: jpgData!)
        let task = ses.uploadTask(withStreamedRequest: req as URLRequest)
        task.resume()
    }
    
}

