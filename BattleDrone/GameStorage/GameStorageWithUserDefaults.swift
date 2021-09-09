//
//  GameStorageWithUserDefaults.swift
//  BattleDrone
//
//  Created by Shawn Yapa on 9/8/21.
//

import Foundation

class GameStorageWithUserDefaults: GameStorage {
    
    let activeGameConfigurationPrefix = "BattleDrone_ActiveGameConfigurationId"
    let gameConfigurationPrefix = "BattleDrone_GameConfiguration_"
    let userDefaults = UserDefaults.standard
    
    func saveGameConfiguration(gameConfiguration: GameConfiguration) {
        if let encodedGameConfig = encodeGameConfiguration(gameConfiguration: gameConfiguration) {
            userDefaults.set(encodedGameConfig, forKey: gameConfigurationKey(gameConfigurationIdString: gameConfiguration.id.uuidString))
            saveActiveGameConfiguration(gameConfigIdString: gameConfiguration.id.uuidString)
        }
    }
    
    func returnAllGameConfigurations() -> [GameConfiguration] {
        let keys = allGameConfigurationKeys()
        var gameConfigurations = [GameConfiguration]()
        // ***SY Consider Refactor as .map
        for key in keys {
            if let data = userDefaults.value(forKeyPath: key) as? Data {
                if let gameConfiguration = decodeGameConfiguration(data: data) {
                    gameConfigurations.append(gameConfiguration)
                }
            }
        }
        return gameConfigurations
    }
    
    func removeAllGameConfigurations() {
        let keys = allGameConfigurationKeys()
        for key in keys {
            userDefaults.removeObject(forKey: key)
        }
        userDefaults.removeObject(forKey: activeGameConfigurationPrefix)
    }
    
    func findGameConfigurationById(idString: String) -> GameConfiguration? {
        let key = gameConfigurationKey(gameConfigurationIdString: idString)
        if let data = userDefaults.value(forKeyPath: key) as? Data {
            if let gameConfiguration = decodeGameConfiguration(data: data) {
                return gameConfiguration
            }
        }
        return nil
    }
    
    func removeGameConfigurationById(idString: String) {
        userDefaults.removeObject(forKey: gameConfigurationKey(gameConfigurationIdString: idString))
    }
    
    func activeGameConfiguration() -> GameConfiguration {
        if let activeGameConfigIdString = userDefaults.value(forKey: activeGameConfigurationPrefix) as? String {
            if let data = userDefaults.value(forKey: gameConfigurationKey(gameConfigurationIdString: activeGameConfigIdString)) as? Data {
                if let gameConfiguration = decodeGameConfiguration(data: data) {
                    return gameConfiguration
                }
            }
        }
        return GameConfiguration.defaultConfiguration()
    }
    
    private func saveActiveGameConfiguration(gameConfigIdString: String) {
        userDefaults.setValue(gameConfigIdString, forKey: activeGameConfigurationPrefix)
    }
    
    private func gameConfigurationKey(gameConfigurationIdString: String) -> String {
        return "\(gameConfigurationPrefix)\(gameConfigurationIdString)"
    }
    
    private func allGameConfigurationKeys() -> [String] {
        let keys = userDefaults.dictionaryRepresentation().keys.filter {
            $0.contains(self.gameConfigurationPrefix)
        }
        return keys
    }
    
    private func encodeGameConfiguration(gameConfiguration: GameConfiguration) -> Data? {
        let encoder = JSONEncoder()
        if let encodedGameConfig = try? encoder.encode(gameConfiguration) {
            return encodedGameConfig
        }
        return nil
    }
    
    private func decodeGameConfiguration(data: Data) -> GameConfiguration? {
        let decoder = JSONDecoder()
        if let gameConfiguration = try? decoder.decode(GameConfiguration.self, from: data) {
            return gameConfiguration
        }
        return nil
    }
}
