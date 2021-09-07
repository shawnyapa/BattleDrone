//
//  GameConfigurationViewController.swift
//  BattleDrone
//
//  Created by Shawn Yapa on 9/1/21.
//

import Foundation
import UIKit

class GameConfigurationViewController: UIViewController {

    var gameConfigurationView: GameConfigurationView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameConfigurationView = GameConfigurationView()
        // ***SY Implement Get Game Config with Persistence layer
        gameConfigurationView?.setupViewWithGameConfiguration()
        gameConfigurationView?.gameConfigurationViewDelegate = self
        view = gameConfigurationView
    }
    
    
    func validateUserInput(gameConfiguration: GameConfiguration) -> Bool {
        if gameConfiguration.username.isEmpty || gameConfiguration.username == GameConfiguration.defaultUsername {
            return false
        } else {
            return true
        }
    }
    
    func saveUserInput(gameConfiguration: GameConfiguration) {
        // ***SY Implement Set Game Config with Persistence layer
        //print(gameConfiguration.username, gameConfiguration.challengeType, gameConfiguration.hitsRequired, gameConfiguration.maxTime, gameConfiguration.targetMovement)
    }
    
    func dismissViewController() {
        dismiss(animated: true, completion: nil)
    }
    
    func showErrorAlert() {
        let errorAlertController = UIAlertController(title: "Game Configuration Error", message: "Please enter a valid Username", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        errorAlertController.addAction(okAction)
        present(errorAlertController, animated: true, completion: nil)
    }
}

extension GameConfigurationViewController: GameConfigurationViewDelegate {
    func saveButtonPressed(gameConfiguration: GameConfiguration) {
        if validateUserInput(gameConfiguration: gameConfiguration) {
            saveUserInput(gameConfiguration: gameConfiguration)
            dismissViewController()
        } else {
            showErrorAlert()
        }
    }
    
    func cancelButtonPressed() {
        dismissViewController()
    }
}
