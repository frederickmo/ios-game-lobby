//
//  CommentModel.swift
//  gameLobby
//
//  Created by Frederick Mo on 2022/5/24.
//

import Foundation


struct Comment: Identifiable {
    
    let id = UUID()
    
    var content: String
    var sendTime: String
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
