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
            previewImage: "https://636c-cloud1-7ga8z75a2f0d1148-1309991354.tcb.qcloud.la/game%20cover/naughty%20monkey.jpeg?sign=274ca8e2c4cec408e39775c00e825bf8&t=1654702085",
            description: "简单刺激的动作类小游戏。点击屏幕操纵小猴在两棵大树之间跳跃，注意避开沿途的障碍物！",
            appPath: "",
            
            category: ["单机", "动作"],
            tags: [.offline, .action]),
        Game(
            name: "MikuDance",
            displayName: "与我共舞 Dancing Miku",
            previewImage: "https://636c-cloud1-7ga8z75a2f0d1148-1309991354.tcb.qcloud.la/game%20cover/dancing%20miku.jpg?sign=e01a1f1c1e27b848921ebad15015442d&t=1654702120",
            description: "融合AR技术的全新音游呈现在你的面前！我们荣幸地邀请了Miku和她的小伙伴前来这场盛宴，您也想要参加这场精彩纷呈的舞会吗？",
            appPath: "DancingMiku://",
            category: ["单机", "音乐", "休闲"],
            tags: [.offline, .rhythm]),
        Game(
            name: "HandTip",
            displayName: "HandTip",
            previewImage: "https://636c-cloud1-7ga8z75a2f0d1148-1309991354.tcb.qcloud.la/game%20cover/hand%20tip.jpg?sign=366fdc9149b17c88c9c708508985f3f0&t=1654702138",
            description: "融合手部识别技术的音乐游戏，让你体会节奏大师般畅爽体验。",
            appPath: "",
            category: ["单机", "音乐"],
            tags: [.offline, .rhythm]),
        Game(
            name: "BombingMan",
            displayName: "炸弹人 Bombing Man",
            previewImage: "https://636c-cloud1-7ga8z75a2f0d1148-1309991354.tcb.qcloud.la/game%20cover/bomberman.jpg?sign=6647de321b5cea8e1dba67f6e2ed07bf&t=1654702161",
            description: "儿时的炸弹人带来的无限美好，在此为你重新呈现。",
            appPath: "",
            category: ["在线", "竞技", "休闲"],
            tags: [.online, .competitive]),
        Game(
            name: "",
            displayName: "QQ堂",
            previewImage: "https://636c-cloud1-7ga8z75a2f0d1148-1309991354.tcb.qcloud.la/game%20cover/qq%20tang.jpg?sign=4ec0535ac52b84303356f2ee85194ae7&t=1654702177",
            description: "",
            appPath: "",
            category: ["在线", "休闲", "竞技"],
            tags: [.online, .casual, .competitive]),
        Game(
            name: "",
            displayName: "肥猫天使",
            previewImage: "https://636c-cloud1-7ga8z75a2f0d1148-1309991354.tcb.qcloud.la/game%20cover/twin%20shot.png?sign=539f00c1a9b88e46c9a46aa232ea1681&t=1654702190",
            description: "",
            appPath: "",
            category: ["单机", "休闲", "动作"],
            tags: [.offline, .casual, .action]),
        Game(
            name: "",
            displayName: "冰激凌坏蛋",
            previewImage: "https://636c-cloud1-7ga8z75a2f0d1148-1309991354.tcb.qcloud.la/game%20cover/bad%20ice%20cream.jpeg?sign=9dcab1c75b3828da028a1878427998f3&t=1654702202",
            description: "",
            appPath: "",
            category: ["单机", "休闲", "动作"],
            tags: [.offline, .casual, .action]),
        Game(
            name: "",
            displayName: "神奇蓝药水",
             previewImage: "https://636c-cloud1-7ga8z75a2f0d1148-1309991354.tcb.qcloud.la/game%20cover/test%20subject%20arena.png?sign=49805f7ccfd5a20812c35c56c095340a&t=1654702212",
             description: "",
             appPath: "",
             category: ["单机", "休闲", "动作"],
             tags: [.offline, .casual, .action]),
        Game(
            name: "",
            displayName: "小鳄鱼爱洗澡",
            previewImage: "https://636c-cloud1-7ga8z75a2f0d1148-1309991354.tcb.qcloud.la/game%20cover/wheres%20my%20water.jpg?sign=f4656b51dd0240d3963db5d5a98897fb&t=1654702222",
            description: "",
            appPath: "",
            category: ["单机", "休闲", "益智"],
            tags: [.offline, .casual, .puzzle]),
        Game(
            name: "",
            displayName: "保卫萝卜",
            previewImage: "https://636c-cloud1-7ga8z75a2f0d1148-1309991354.tcb.qcloud.la/game%20cover/carrot%20fantasy.jpeg?sign=a058682c85158009b743e63cd7aa6c71&t=1654702236",
            description: "",
            appPath: "",
            category: ["单机", "休闲", "益智", "策略"],
            tags: [.offline, .casual, .puzzle, .strategy])
    ]
    
    static let myGame: [Game] = [
        Game(
            name: "NaughtyMonkey",
            displayName: "Naughty Monkey",
            previewImage: "https://636c-cloud1-7ga8z75a2f0d1148-1309991354.tcb.qcloud.la/game%20cover/naughty%20monkey.jpeg?sign=274ca8e2c4cec408e39775c00e825bf8&t=1654702085",
            description: "简单刺激的动作类小游戏。点击屏幕操纵小猴在两棵大树之间跳跃，注意避开沿途的障碍物！",
            appPath: "",
            category: ["单机", "动作"],
            tags: [.offline, .action]),
        Game(
            name: "MikuDance",
            displayName: "与我共舞 Dancing Miku",
            previewImage: "https://636c-cloud1-7ga8z75a2f0d1148-1309991354.tcb.qcloud.la/game%20cover/dancing%20miku.jpg?sign=e01a1f1c1e27b848921ebad15015442d&t=1654702120",
            description: "融合AR技术的全新音游呈现在你的面前！我们荣幸地邀请了Miku和她的小伙伴前来这场盛宴，您也想要参加这场精彩纷呈的舞会吗？",
            appPath: "DancingMiku://",
            category: ["单机", "音乐", "休闲"],
            tags: [.offline, .rhythm]),
        Game(
            name: "HandTip",
            displayName: "HandTip",
            previewImage: "https://636c-cloud1-7ga8z75a2f0d1148-1309991354.tcb.qcloud.la/game%20cover/hand%20tip.jpg?sign=366fdc9149b17c88c9c708508985f3f0&t=1654702138",
            description: "融合手部识别技术的音乐游戏，让你体会节奏大师般畅爽体验。",
            appPath: "",
            category: ["单机", "音乐"],
            tags: [.offline, .rhythm]),
        Game(
            name: "BombingMan",
            displayName: "炸弹人 Bombing Man",
            previewImage: "https://636c-cloud1-7ga8z75a2f0d1148-1309991354.tcb.qcloud.la/game%20cover/bomberman.jpg?sign=6647de321b5cea8e1dba67f6e2ed07bf&t=1654702161",
            description: "儿时的炸弹人带来的无限美好，在此为你重新呈现。",
            appPath: "",
            category: ["在线", "竞技", "休闲"],
            tags: [.online, .competitive])
    ]
}

