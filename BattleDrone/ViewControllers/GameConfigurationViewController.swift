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
        gameConfigurationView?.setupView()
        gameConfigurationView?.gameConfigurationViewDelegate = self
        view = gameConfigurationView
    }
    
    
    func validateUserInput() -> Bool {
        
        return true
    }
    
    func saveUserInput() {
        
    }
    
    func dismissViewController() {
        dismiss(animated: true, completion: nil)
    }
    
    func showErrorAlert() {
        
    }
}

extension GameConfigurationViewController: GameConfigurationViewDelegate {
    func saveButtonPressed() {
        if validateUserInput() {
            saveUserInput()
            dismissViewController()
        } else {
            showErrorAlert()
        }
    }
    
    func cancelButtonPressed() {
        dismissViewController()
    }
}
