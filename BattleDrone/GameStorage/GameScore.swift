//
//  GameScore.swift
//  BattleDrone
//
//  Created by Shawn Yapa on 9/8/21.
//

import Foundation

struct GameScore: Codable, Identifiable {
    
    let id: UUID
    let gameConfigId: String
    let totalBullets: Int
    let bulletHits: Int
    let totalTime: Float
    let initialDistanceToTarget: Float
    
    static func createUniqueId() -> UUID {
        return UUID()
    }
}
