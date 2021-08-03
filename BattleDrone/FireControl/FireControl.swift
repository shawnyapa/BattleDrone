//
//  FireControl.swift
//  ARExperiment3
//
//  Created by Shawn Yapa on 6/28/21.
//

import Foundation
import UIKit
import RealityKit

protocol HasWeapon {
    func createBullets()
    func setupGunFirePoint() -> ModelEntity
    func gunFirePointDelta() -> SIMD3<Float>
    func moveBulletToFirePoint(bullet: Bullet)
    func launchBullet(bullet: Bullet)
    func fireBullet()
}

protocol FireControlDelegate {
    func rotateGunUp()
    func rotateGunDown()
    func rotateGunLeft()
    func rotateGunRight()
    func fireBullet()
}

class FireControl: FireControlDelegate {
    
    var weapon: (Entity & HasWeapon)?
    var fireControlView: FireControlView?
    
    convenience init(weapon: (Entity & HasWeapon)) {
        self.init()
        self.weapon = weapon
        fireControlView = FireControlView(fireControlDelegate: self)
    }
    
    // MARK: FireControlDelegate Methods
    func rotateGunUp() {
        guard let weapon = weapon else {
            return
        }
        let radians = 1.0 * Float.pi / 180.0
        let transform = Transform(pitch: 0, yaw: 0, roll: radians)
        weapon.move(to: transform, relativeTo: weapon, duration: 0.01)
    }

    func rotateGunDown() {
        guard let weapon = weapon else {
            return
        }
        let radians = -1.0 * Float.pi / 180.0
        let transform = Transform(pitch: 0, yaw: 0, roll: radians)
        weapon.move(to: transform, relativeTo: weapon, duration: 0.01)
    }
    
    func rotateGunLeft() {
        guard let weapon = weapon else {
            return
        }
        let radians = 1.0 * Float.pi / 180.0
        let transform = Transform(pitch: 0, yaw: radians, roll: 0)
        weapon.move(to: transform, relativeTo: weapon, duration: 0.01)
    }

    func rotateGunRight() {
        guard let weapon = weapon else {
            return
        }
        let radians = -1.0 * Float.pi / 180.0
        let transform = Transform(pitch: 0, yaw: radians, roll: 0)
        weapon.move(to: transform, relativeTo: weapon, duration: 0.01)
    }
        
    func fireBullet() {
        guard let weapon = weapon else {
            return
        }
        weapon.fireBullet()
    }
}
