//
//  UserDataViewModel.swift
//  gameLobby
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

        // generate boundary string using a unique per-app string
        let boundary = UUID().uuidString

        let session = URLSession.shared

        // Set the URLRequest to POST and to the specified URL
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "POST"

        // Set Content-Type Header to multipart/form-data, this is equivalent to submitting form data with file upload in a web browser
        // And the boundary is also set here
        urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        var data = Data()

        // Add the image data to the raw http request data
        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; email=\"\(email)\"; token=\"\(token)\"\r\n".data(using: .utf8)!)
        data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
        data.append(image.pngData()!)

        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)

        // Send a POST request to the URL, with the data we created earlier
        session.uploadTask(with: urlRequest, from: data, completionHandler: { responseData, response, error in
            if error == nil {
                let jsonData = try? JSONSerialization.jsonObject(with: responseData!, options: .allowFragments)
                if let json = jsonData as? [String: Any] {
                    print(json)
                }
            }
        }).resume()
    }
    
}

