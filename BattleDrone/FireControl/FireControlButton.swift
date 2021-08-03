//
//  FireControlButton.swift
//  ARExperiment3
//
//  Created by Shawn Yapa on 5/25/21.
//

import Foundation
import UIKit

enum FireControlButtonType {
    case Up
    case Down
    case Left
    case Right
    case Fire
}

class FireControlButton: UIButton {
    
    var fireControlButtonType: FireControlButtonType = .Up
    var fireControlDelegate: FireControlDelegate?
    var buttonIsPressed: Bool = false
    
    convenience init(frame: CGRect, buttonType: FireControlButtonType, delegate: FireControlDelegate) {
        self.init(frame: frame)
        fireControlButtonType = buttonType
        fireControlDelegate = delegate
        setupButtonImage(buttonType: buttonType)
    }
    
    func setupButtonImage(buttonType: FireControlButtonType) {
        switch buttonType {
        case .Up:
            self.setImage(UIImage(systemName: "arrow.up.circle"), for: .normal)
        case .Down:
            self.setImage(UIImage(systemName: "arrow.down.circle"), for: .normal)
        case .Left:
            self.setImage(UIImage(systemName: "arrow.left.circle"), for: .normal)
        case .Right:
            self.setImage(UIImage(systemName: "arrow.right.circle"), for: .normal)
        case .Fire:
            if let fireImage = UIImage(systemName: "circle.circle") {
                self.setImage(fireImage, for: .normal)
            }
        }
        self.contentVerticalAlignment = .fill
        self.contentHorizontalAlignment = .fill
        self.imageEdgeInsets = UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if fireControlButtonType != .Fire {
            startMovement()
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if fireControlButtonType == .Fire {
            fireBullet()
        } else {
            stopMovement()
        }
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        stopMovement()
    }
    
    func startMovement() {
        buttonIsPressed = true
        Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { timer in
            if self.buttonIsPressed == false {
                timer.invalidate()
            }
            guard let delegate = self.fireControlDelegate else {
                return
            }
            switch (self.fireControlButtonType) {
            case .Up:
                delegate.rotateGunUp()
            case .Down:
                delegate.rotateGunDown()
            case .Left:
                delegate.rotateGunLeft()
            case .Right:
                delegate.rotateGunRight()
            case .Fire:
                delegate.fireBullet()
            }
        }
    }
    
    func stopMovement() {
        buttonIsPressed = false
    }
    
    func fireBullet() {
        guard let delegate = self.fireControlDelegate else {
            return
        }
        delegate.fireBullet()
    }
}
