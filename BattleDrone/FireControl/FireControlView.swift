//
//  FireControlView.swift
//  ARExperiment3
//
//  Created by Shawn Yapa on 6/28/21.
//

import Foundation
import UIKit

class FireControlView: UIView {
    
    var upButton: FireControlButton?
    var downButton: FireControlButton?
    var leftButton: FireControlButton?
    var rightButton: FireControlButton?
    var fireButton: FireControlButton?
    
    convenience init(fireControlDelegate: FireControlDelegate) {
        self.init()
        setupUserButtons(fireControlDelegate: fireControlDelegate)
    }
    
    func setupUserButtons(fireControlDelegate: FireControlDelegate) {
        let buttonSize = CGFloat(100)
        let margins = layoutMarginsGuide
        let frame = CGRect()
        let fireButton = FireControlButton(frame: frame, buttonType: .Fire, delegate: fireControlDelegate)
        fireButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(fireButton)
        fireButton.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -100).isActive = true
        fireButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        fireButton.widthAnchor.constraint(equalToConstant: buttonSize).isActive = true
        fireButton.heightAnchor.constraint(equalToConstant: buttonSize).isActive = true
        self.fireButton = fireButton
        
        let upButton = FireControlButton(frame: frame, buttonType: .Up, delegate: fireControlDelegate)
        upButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(upButton)
        upButton.bottomAnchor.constraint(equalTo: fireButton.topAnchor, constant: -20).isActive = true
        upButton.centerXAnchor.constraint(equalTo: fireButton.centerXAnchor).isActive = true
        upButton.widthAnchor.constraint(equalToConstant: buttonSize).isActive = true
        upButton.heightAnchor.constraint(equalToConstant: buttonSize).isActive = true
        self.upButton = upButton
        
        let downButton = FireControlButton(frame: frame, buttonType: .Down, delegate: fireControlDelegate)
        downButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(downButton)
        downButton.topAnchor.constraint(equalTo: fireButton.bottomAnchor, constant: 20).isActive = true
        downButton.centerXAnchor.constraint(equalTo: fireButton.centerXAnchor).isActive = true
        downButton.widthAnchor.constraint(equalToConstant: buttonSize).isActive = true
        downButton.heightAnchor.constraint(equalToConstant: buttonSize).isActive = true
        self.downButton = downButton
        
        let leftButton = FireControlButton(frame: frame, buttonType: .Left, delegate: fireControlDelegate)
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(leftButton)
        leftButton.rightAnchor.constraint(equalTo: fireButton.leftAnchor, constant: -20).isActive = true
        leftButton.centerYAnchor.constraint(equalTo: fireButton.centerYAnchor).isActive = true
        leftButton.widthAnchor.constraint(equalToConstant: buttonSize).isActive = true
        leftButton.heightAnchor.constraint(equalToConstant: buttonSize).isActive = true
        self.leftButton = leftButton
        
        
        let rightButton = FireControlButton(frame: frame, buttonType: .Right, delegate: fireControlDelegate)
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(rightButton)
        rightButton.leftAnchor.constraint(equalTo: fireButton.rightAnchor, constant: 20).isActive = true
        rightButton.centerYAnchor.constraint(equalTo: fireButton.centerYAnchor).isActive = true
        rightButton.widthAnchor.constraint(equalToConstant: buttonSize).isActive = true
        rightButton.heightAnchor.constraint(equalToConstant: buttonSize).isActive = true
        self.rightButton = rightButton
        
        setNeedsDisplay()
    }
        
}
