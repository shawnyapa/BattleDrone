//
//  GameViewController.swift
//  BattleDrone
//
//  Created by Shawn Yapa on 8/2/21.
//

import Foundation
import UIKit

class GameViewController: UIViewController, GameViewDelegate {
    
    var gameController: GameController = GameController()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let gameView = GameView()
        gameView.gameViewDelegate = self
        gameView.setupView()
        view = gameView
    }

    func startButtonPressed() {
        guard let gameView = view as? GameView else {
            return
        }
        gameView.startButton.isHidden = true
        gameController.layoutGameARView(forView: view)
        gameController.startGame()
    }

}
