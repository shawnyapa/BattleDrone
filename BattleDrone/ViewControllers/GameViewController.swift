//
//  GameViewController.swift
//  BattleDrone
//
//  Created by Shawn Yapa on 8/2/21.
//

import Foundation
import UIKit

// Note: This View Controller is the initial View in the Game
class GameViewController: UIViewController {
    
    var gameController: GameController = GameController()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let gameView = GameView()
        gameView.gameViewDelegate = self
        gameView.setupView()
        view = gameView
    }

}

extension GameViewController: GameViewDelegate {
    
    func startButtonPressed() {
        guard let gameView = view as? GameView else {
            return
        }
        gameView.startButton.isHidden = true
        gameController.layoutGameARView(forView: view)
        gameController.startGame()
    }
    
    func configureGameButtonPressed() {
        let gameConfigureViewController = GameConfigurationViewController()
        present(gameConfigureViewController, animated: true, completion: nil)
    }
}
