//
//  GameView.swift
//  BattleDrone
//
//  Created by Shawn Yapa on 8/2/21.
//

import Foundation
import UIKit

protocol GameViewDelegate: AnyObject {
    func startButtonPressed()
    func configureGameButtonPressed()
}

class GameView: UIView {
    
    weak var gameViewDelegate: GameViewDelegate?
    let startButton = UIButton()
    let configureGameButton = UIButton()
    
    func setupView () {
        backgroundColor = .white
        startButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(startButton)
        startButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        startButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        startButton.setTitle("Start Game", for: .normal)
        startButton.setTitleColor(.black, for: .normal)
        startButton.addTarget(self, action: #selector(startButtonPressed(_:)), for: .touchUpInside)
        
        configureGameButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(configureGameButton)
        configureGameButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        configureGameButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30).isActive = true
        configureGameButton.setTitle("Configure Game", for: .normal)
        configureGameButton.setTitleColor(.black, for: .normal)
        configureGameButton.addTarget(self, action: #selector(configureGameButtonPressed(_ :)), for: .touchUpInside)
    }
    
    @objc func startButtonPressed(_ sender:UIButton) {
        gameViewDelegate?.startButtonPressed()
    }
    
    @objc func configureGameButtonPressed(_ sender:UIButton) {
        gameViewDelegate?.configureGameButtonPressed()
    }
}
