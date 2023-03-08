//
//  ImageManager.swift
//  gameLobby
//
//  Created by Frederick Mo on 2022/6/3.
//

import Foundation

struct ImageManager
{
    func uploadImage(data: Data, completionHandler: @escaping(_ result: ImageResponse) -> Void)
    {
        let httpUtility = HttpUtility()

        let imageUploadRequest = ImageRequest(attachment: data.base64EncodedString(), fileName: "multipartFormUploadExample")

        httpUtility.postApiDataWithMultipartForm(requestUrl: URL(string: Endpoints.uploadImageMultiPartForm)!, request: imageUploadRequest, resultType: ImageResponse.self) {
            (response) in

            _ = completionHandler(response)

        }

    }
}
