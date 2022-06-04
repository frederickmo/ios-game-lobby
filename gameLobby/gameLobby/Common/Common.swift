//
//  Common.swift
//  gameLobby
//
//  Created by Frederick Mo on 2022/6/3.
//

import Foundation

struct Endpoints
{
    static let uploadImage = "https://api-dev-scus-demo.azurewebsites.net/api/Image/UploadImage"
    static let uploadImageWithByteArray = "https://api-dev-scus-demo.azurewebsites.net/api/Image/UploadImageWithByteArray"
    static let uploadImageMultiPartForm = "https://api-dev-scus-demo.azurewebsites.net/api/Image/UploadImageMultiPartForm"
}

// Use this endpoint for your code challenge.
struct ChallengeEndpoint
{
    static let multiPart = "https://api-dev-scus-demo.azurewebsites.net/api/Employee/MultiPartCodeChallenge"
}
