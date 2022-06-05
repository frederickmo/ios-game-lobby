//
//  CommentModel.swift
//  gameLobby
//
//  Created by Frederick Mo on 2022/5/24.
//

import Foundation


struct Comment: Identifiable {
    
    let id = UUID()
    
    var userName: String
    var content: String
    var rating: Int
    
    static func getCurrentDate() -> String {
        let today = Date()
        let timeZone = NSTimeZone.system
        let interval = timeZone.secondsFromGMT()
        let now = today.addingTimeInterval(TimeInterval(interval))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: now)
        return dateString
    }
}

struct CommentItem: Decodable, Identifiable {
    
    let id = UUID()
    
    var email: String
    var userName: String
    var description: String
    var gameName: String
    var score: Int
}

struct CommentList: Decodable {
    var msg: String
    var comments: [CommentItem]
    var status: String
    var averageScore: Double
}
