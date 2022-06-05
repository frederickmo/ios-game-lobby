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
    case puzzle = "益智"
    case strategy = "策略"
}

struct Game: Identifiable {
    let id = UUID()
    
    let name: String
    let displayName: String
    let previewImage: String
    let description: String
    
    let appPath: String
    
    let category: [Category.RawValue]
    let tags: [Category]
}

extension Game {
    static let all: [Game] = [
        Game(
            name: "NaughtyMonkey",
            displayName: "Naughty Monkey",
            previewImage: "https://636c-cloud1-0g0508tg0810d86e-1311181945.tcb.qcloud.la/exported%20data/ios%20game%20lobby/image/naughty_monkey.jpg?sign=3ded738f4d89a83be1084f2b9d3def7d&t=1652961678",
            description: "简单刺激的动作类小游戏。点击屏幕操纵小猴在两棵大树之间跳跃，注意避开沿途的障碍物！",
            appPath: "",
            
            category: ["单机", "动作"],
            tags: [.offline, .action]),
        Game(
            name: "MikuDance",
            displayName: "与我共舞 Dancing Miku",
            previewImage: "https://636c-cloud1-0g0508tg0810d86e-1311181945.tcb.qcloud.la/exported%20data/ios%20game%20lobby/image/dancing_miku.png?sign=315e21fdc853f2d54fe357a19124fa4e&t=1652961693",
            description: "融合AR技术的全新音游呈现在你的面前！我们荣幸地邀请了Miku和她的小伙伴前来这场盛宴，您也想要参加这场精彩纷呈的舞会吗？",
            appPath: "DancingMiku://",
            category: ["单机", "音乐", "休闲"],
            tags: [.offline, .rhythm]),
        Game(
            name: "HandTip",
            displayName: "HandTip",
            previewImage: "https://636c-cloud1-0g0508tg0810d86e-1311181945.tcb.qcloud.la/exported%20data/ios%20game%20lobby/image/hand_tracking_rhythm_game.jpg?sign=2bb106638006c36267b8bb9a511b4872&t=1652961704",
            description: "融合手部识别技术的音乐游戏，让你体会节奏大师般畅爽体验。",
            appPath: "",
            category: ["单机", "音乐"],
            tags: [.offline, .rhythm]),
        Game(
            name: "BombingMan",
            displayName: "炸弹人 Bombing Man",
            previewImage: "https://636c-cloud1-0g0508tg0810d86e-1311181945.tcb.qcloud.la/exported%20data/ios%20game%20lobby/image/bomberman.jpg?sign=4461d0ed92d78620fb1d15d943e38da2&t=1652961714",
            description: "儿时的炸弹人带来的无限美好，在此为你重新呈现。",
            appPath: "",
            category: ["在线", "竞技", "休闲"],
            tags: [.online, .competitive]),
        Game(
            name: "",
            displayName: "QQ堂",
            previewImage: "https://636c-cloud1-0g0508tg0810d86e-1311181945.tcb.qcloud.la/exported%20data/ios%20game%20lobby/image/qq%20tang.jpg?sign=71e3b2c1188feaaac03cba59d4bdeb8f&t=1653068049",
            description: "",
            appPath: "",
            category: ["在线", "休闲", "竞技"],
            tags: [.online, .casual, .competitive]),
        Game(
            name: "",
            displayName: "肥猫天使",
            previewImage: "https://636c-cloud1-0g0508tg0810d86e-1311181945.tcb.qcloud.la/exported%20data/ios%20game%20lobby/image/twin_shot.png?sign=aeedc0e9108620eaf00f4b1c5ab77b24&t=1653067634",
            description: "",
            appPath: "",
            category: ["单机", "休闲", "动作"],
            tags: [.offline, .casual, .action]),
        Game(
            name: "",
            displayName: "冰激凌坏蛋",
            previewImage: "https://636c-cloud1-0g0508tg0810d86e-1311181945.tcb.qcloud.la/exported%20data/ios%20game%20lobby/image/bad_ice_cream.png?sign=a11ef50a8817fab3898b1b5db5cad59d&t=1653067689",
            description: "",
            appPath: "",
            category: ["单机", "休闲", "动作"],
            tags: [.offline, .casual, .action]),
        Game(
            name: "",
            displayName: "神奇蓝药水",
             previewImage: "https://636c-cloud1-0g0508tg0810d86e-1311181945.tcb.qcloud.la/exported%20data/ios%20game%20lobby/image/test_subject_arena.png?sign=f79455f12b58ef140b7231d9f9081c8a&t=1653067739",
             description: "",
             appPath: "",
             category: ["单机", "休闲", "动作"],
             tags: [.offline, .casual, .action]),
        Game(
            name: "",
            displayName: "小鳄鱼爱洗澡",
            previewImage: "https://636c-cloud1-0g0508tg0810d86e-1311181945.tcb.qcloud.la/exported%20data/ios%20game%20lobby/image/wheres_my_water.jpg?sign=a1b54f22c715bcdfe2bb496f7b0fd967&t=1653067769",
            description: "",
            appPath: "",
            category: ["单机", "休闲", "益智"],
            tags: [.offline, .casual, .puzzle]),
        Game(
            name: "",
            displayName: "保卫萝卜",
            previewImage: "https://636c-cloud1-0g0508tg0810d86e-1311181945.tcb.qcloud.la/exported%20data/ios%20game%20lobby/image/protect_carrot.png?sign=4bd28d00d9291269eec304715fc37f53&t=1653067871",
            description: "",
            appPath: "",
            category: ["单机", "休闲", "益智", "策略"],
            tags: [.offline, .casual, .puzzle, .strategy])
    ]
    
    static let myGame: [Game] = [
        Game(
            name: "NaughtyMonkey",
            displayName: "Naughty Monkey",
            previewImage: "https://636c-cloud1-0g0508tg0810d86e-1311181945.tcb.qcloud.la/exported%20data/ios%20game%20lobby/image/naughty_monkey.jpg?sign=3ded738f4d89a83be1084f2b9d3def7d&t=1652961678",
            description: "简单刺激的动作类小游戏。点击屏幕操纵小猴在两棵大树之间跳跃，注意避开沿途的障碍物！",
            appPath: "",
            category: ["单机", "动作"],
            tags: [.offline, .action]),
        Game(
            name: "MikuDance",
            displayName: "与我共舞 Dancing Miku",
            previewImage: "https://636c-cloud1-0g0508tg0810d86e-1311181945.tcb.qcloud.la/exported%20data/ios%20game%20lobby/image/dancing_miku.png?sign=315e21fdc853f2d54fe357a19124fa4e&t=1652961693",
            description: "融合AR技术的全新音游呈现在你的面前！我们荣幸地邀请了Miku和她的小伙伴前来这场盛宴，您也想要参加这场精彩纷呈的舞会吗？",
            appPath: "DancingMiku://",
            category: ["单机", "音乐", "休闲"],
            tags: [.offline, .rhythm]),
        Game(
            name: "HandTip",
            displayName: "HandTip",
            previewImage: "https://636c-cloud1-0g0508tg0810d86e-1311181945.tcb.qcloud.la/exported%20data/ios%20game%20lobby/image/hand_tracking_rhythm_game.jpg?sign=2bb106638006c36267b8bb9a511b4872&t=1652961704",
            description: "融合手部识别技术的音乐游戏，让你体会节奏大师般畅爽体验。",
            appPath: "",
            category: ["单机", "音乐"],
            tags: [.offline, .rhythm]),
        Game(
            name: "BombingMan",
            displayName: "炸弹人 Bombing Man",
            previewImage: "https://636c-cloud1-0g0508tg0810d86e-1311181945.tcb.qcloud.la/exported%20data/ios%20game%20lobby/image/bomberman.jpg?sign=4461d0ed92d78620fb1d15d943e38da2&t=1652961714",
            description: "儿时的炸弹人带来的无限美好，在此为你重新呈现。",
            appPath: "",
            category: ["在线", "竞技", "休闲"],
            tags: [.online, .competitive])
    ]
}

