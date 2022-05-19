//
//  GameModel.swift
//  gameLobby
//
//  Created by Frederick Mo on 2022/5/19.
//

import Foundation
import SwiftUI

enum Category: String, CaseIterable, Identifiable {
    var id: String { self.rawValue }
    case online = "在线"
    case offline = "单机"
    case casual = "休闲"
    case rhythm = "音乐"
    case action = "动作"
    case competitive = "竞技"
}

struct Game: Identifiable {
    let id = UUID()
    
    let name: String
    let previewImage: String
    let description: String
    let direction: String
    
    let category: [Category.RawValue]
    let tags: [Category]
}

extension Game {
    static let all: [Game] = [
        Game(
            name: "Naughty Monkey",
            previewImage: "https://636c-cloud1-0g0508tg0810d86e-1311181945.tcb.qcloud.la/exported%20data/ios%20game%20lobby/image/naughty_monkey.jpg?sign=3ded738f4d89a83be1084f2b9d3def7d&t=1652961678",
            description: "简单刺激的动作类小游戏。点击屏幕操纵小猴在两棵大树之间跳跃，注意避开沿途的障碍物！",
            direction: "",
            category: ["单机", "动作"],
            tags: [.offline, .action]),
        Game(
            name: "与我共舞 Dancing Miku",
            previewImage: "https://636c-cloud1-0g0508tg0810d86e-1311181945.tcb.qcloud.la/exported%20data/ios%20game%20lobby/image/dancing_miku.png?sign=315e21fdc853f2d54fe357a19124fa4e&t=1652961693",
            description: "融合AR技术的全新音游呈现在你的面前！我们荣幸地邀请了Miku和她的小伙伴前来这场盛宴，您也想要参加这场精彩纷呈的舞会吗？",
            direction: "",
            category: ["单机", "音乐"],
            tags: [.offline, .rhythm]),
        Game(
            name: "Hand Tracing Rhythm Game",
            previewImage: "https://636c-cloud1-0g0508tg0810d86e-1311181945.tcb.qcloud.la/exported%20data/ios%20game%20lobby/image/hand_tracking_rhythm_game.jpg?sign=2bb106638006c36267b8bb9a511b4872&t=1652961704",
            description: "融合手部识别技术的音乐游戏，让你体会节奏大师般畅爽体验。",
            direction: "",
            category: ["单机", "音乐"],
            tags: [.offline, .rhythm]),
        Game(
            name: "炸弹人 Bombing Man",
            previewImage: "https://636c-cloud1-0g0508tg0810d86e-1311181945.tcb.qcloud.la/exported%20data/ios%20game%20lobby/image/bomberman.jpg?sign=4461d0ed92d78620fb1d15d943e38da2&t=1652961714",
            description: "儿时的炸弹人带来的无限美好，在此为你重新呈现。",
            direction: "",
            category: ["在线", "竞技"],
            tags: [.online, .competitive]),
    ]
}

