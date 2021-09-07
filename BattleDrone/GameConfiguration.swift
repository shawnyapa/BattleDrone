//
//  GameConfiguration.swift
//  BattleDrone
//
//  Created by Shawn Yapa on 9/4/21.
//

import Foundation

enum ChallengeType: Int, Codable {
    case hitsRequired
    case maxTime
}

enum TargetMovement: Int, Codable {
    case fixed
    case easy
    case medium
    case hard
}

struct GameConfiguration: Codable {
    
    static let defaultUsername = "Your Username"
    
    let username: String
    let challengeType: ChallengeType
    let hitsRequired: Int
    let maxTime: Int
    let targetMovement: TargetMovement
    
    static func defaultConfiguration() -> GameConfiguration {
        GameConfiguration(username: GameConfiguration.defaultUsername, challengeType: .hitsRequired, hitsRequired: 10, maxTime: 30, targetMovement: .fixed)
    }
}
