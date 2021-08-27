//
//  GameView.swift
//  BattleDrone
//
//  Created by Shawn Yapa on 8/2/21.
//

import Foundation
import UIKit

protocol GameViewDelegate {
    func startButtonPressed()
}

class GameView: UIView {
    
    var gameViewDelegate: GameViewDelegate?
    let startButton = UIButton()
    
    func setupView () {
        startButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(startButton)
        startButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        startButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        startButton.widthAnchor.constraint(equalToConstant: CGFloat(100)).isActive = true
        startButton.heightAnchor.constraint(equalToConstant: CGFloat(60)).isActive = true
        startButton.setTitle("Start Game", for: .normal)
        startButton.addTarget(self, action: #selector(startButtonPressed(_:)), for: .touchUpInside)
    }
    
    @objc func startButtonPressed(_ sender:UIButton) {
        guard let delegate = gameViewDelegate else {
            return
        }
        delegate.startButtonPressed()
    }
}
