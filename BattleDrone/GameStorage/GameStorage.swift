//
//  GameStorage.swift
//  BattleDrone
//
//  Created by Shawn Yapa on 9/8/21.
//

import Foundation

protocol GameStorage {
    func saveGameConfiguration(gameConfiguration: GameConfiguration)
    func returnAllGameConfigurations() -> [GameConfiguration]
    func findGameConfigurationById(idString: String) -> GameConfiguration?
    func removeGameConfigurationById(idString: String)
    func activeGameConfiguration() -> GameConfiguration
}

enum GameStorageType {
    case UserDefaults
}

class GameStorageFactory {
    static func createGameStorage(storageType:GameStorageType) -> GameStorage {
        switch storageType {
            case .UserDefaults:
            return GameStorageWithUserDefaults()
        }
    }
}
