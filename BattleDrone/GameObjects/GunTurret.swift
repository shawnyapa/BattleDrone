//
//  GunTurret.swift
//  ARExperiment3
//
//  Created by Shawn Yapa on 5/26/21.
//

import Foundation
import RealityKit
import UIKit

class GunTurret: Entity, HasModel, HasPhysics, HasCollision, HasWeapon {
    let healthPoints: Int = 100
    let color = UIColor.gray
    let size:Float = 0.05
    var bullets = [Bullet]()
    var totalBullets: Int = 20 // (20+1)
    var activeBullet: Int = 0
    var firePointModel: ModelEntity?
    var fireControl: FireControl?
    var anchorEntity: AnchorEntity?
    
    required init() {
        super.init()
        let meshResource = MeshResource.generateSphere(radius: size)
        let materialResource = SimpleMaterial(color: color, isMetallic: false)
        self.components[ModelComponent] = ModelComponent(mesh: meshResource, materials: [materialResource])
        firePointModel = setupGunFirePoint()
        createBullets()
        fireControl = FireControl(weapon: self)
    }
    
    func setupFireControlForView(view: UIView) {
        guard let fireControlView = fireControl?.fireControlView else {
            return
        }
        let margins = view.layoutMarginsGuide
        view.addSubview(fireControlView)
        fireControlView.translatesAutoresizingMaskIntoConstraints = false
        fireControlView.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -100).isActive = true
        fireControlView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        fireControlView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        fireControlView.heightAnchor.constraint(equalToConstant: CGFloat(300)).isActive = true
    }
    
    func anchorWeaponAndBullets(anchorEntity: AnchorEntity) {
        //addWeaponToScene(anchorEntity: anchorEntity)  // ***SY Handled by GameController Fix
        addBulletsToScene(anchorEntity: anchorEntity)
        self.anchorEntity = anchorEntity
    }
    
    func addWeaponToScene(anchorEntity: AnchorEntity) {
        anchorEntity.addChild(self)
    }
    
    func addBulletsToScene (anchorEntity: AnchorEntity) {
        for i in 0...totalBullets {
            let bullet = bullets[i]
            anchorEntity.addChild(bullet)
            bullet.addCollisions()
        }
    }
    
    // MARK: HasWeapon Protocol Methods
    func createBullets() {
        let bullet = Bullet(velocityVector: gunFirePointDelta(), owner: self)
        bullets.append(bullet)
        for _ in 1...totalBullets {
            let bullet = bullet.clone(recursive: true)
            bullets.append(bullet)
        }
    }
    
    func setupGunFirePoint() -> ModelEntity {
        let sphereResource = MeshResource.generateSphere(radius: 0.01)
        let materialResource = SimpleMaterial(color: .cyan, isMetallic: false)
        let sphere = ModelEntity(mesh: sphereResource, materials: [materialResource])
        addChild(sphere)
        var spherePosition = sphere.position(relativeTo: self)
        spherePosition += SIMD3<Float>(x: 0.05, y: 0, z: 0)
        sphere.setPosition(spherePosition, relativeTo: self)
        return sphere
    }
    
    func gunFirePointDelta() -> SIMD3<Float> {
        guard let anchorEntity = anchorEntity else {
            return SIMD3<Float>()
        }
        guard let deltaPosition = firePointModel?.position(relativeTo: anchorEntity) else {
            return SIMD3<Float>()
        }
        return deltaPosition
    }
    
    func moveBulletToFirePoint(bullet: Bullet) {
        bullet.velocityVector = gunFirePointDelta() //***SY Remove
        var transform2 = Transform()
        transform2.translation = (bullet.velocityVector * 1.1)
        bullet.move(to: transform2, relativeTo: bullet)
    }
    
    func launchBullet(bullet: Bullet) {
        var transform2 = Transform()
        transform2.translation = (bullet.velocityVector * 10)
        let animationController = bullet.move(to: transform2, relativeTo: bullet, duration: 1.0, timingFunction: .linear)
        bullet.animationController = animationController
    }
    
    func fireBullet() {
        if hasAvailableBullets() == false {
            return
        }
        let bullet = bullets[activeBullet]
        bullet.velocityVector = gunFirePointDelta()
        //moveBulletToFirePoint(bullet: bullet) // ***SY Remove and rework HasWeapon Protocol (Compact Methods)
        launchBullet(bullet: bullet)
        activeBullet+=1
    }
    
    func hasAvailableBullets() -> Bool {
        return activeBullet<totalBullets
    }
}
