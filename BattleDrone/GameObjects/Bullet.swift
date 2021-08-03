//
//  Bullet.swift
//  ARExperiment3
//
//  Created by Shawn Yapa on 5/17/21.
//

import Foundation
import RealityKit
import UIKit
import Combine

class Bullet: Entity, HasModel, HasCollision {
    var velocityVector: SIMD3<Float> = SIMD3<Float>()
    var animationController: AnimationPlaybackController?
    var damagePoints: Int = 10
    let color = UIColor.blue
    let size:Float = 0.01
    var collisionSubscription: Cancellable?
    var owner: Entity?
    
    required init() {
        super.init()
        let meshResource = MeshResource.generateSphere(radius: size)
        let materialResource = SimpleMaterial(color: color, isMetallic: false)
        self.components[ModelComponent] = ModelComponent(mesh: meshResource, materials: [materialResource])
        self.components[CollisionComponent] = CollisionComponent(shapes: [ShapeResource.generateSphere(radius: size)], mode: .trigger, filter: .sensor)
    }
    
    init(owner: Entity) {
        super.init()
        let meshResource = MeshResource.generateSphere(radius: size)
        let materialResource = SimpleMaterial(color: color, isMetallic: false)
        self.components[ModelComponent] = ModelComponent(mesh: meshResource, materials: [materialResource])
        self.components[CollisionComponent] = CollisionComponent(shapes: [ShapeResource.generateSphere(radius: size)], mode: .trigger, filter: .sensor)
        self.owner = owner
    }
    
    convenience init(velocityVector: SIMD3<Float>, owner: Entity) {
        self.init(owner: owner)
        self.velocityVector = velocityVector
        
    }
    
    func addCollisions() {
        guard let scene = self.scene else {
            return
        }
        // Add Subscription and Log Bullet Collisions
        let beginSubscription = scene.subscribe(to: CollisionEvents.Began.self, on: self, { event in
            // Do stuff with Event
            if let _ = event.entityA as? Bullet, let _ = event.entityB as? Bullet {
                return
            }
            if let bullet = event.entityA as? Bullet, event.entityB == bullet.owner {
                return
            }
            if let bullet = event.entityB as? Bullet, event.entityA == bullet.owner {
                return
            }
            if let _ = event.entityA as? Bullet, let _ = event.entityB as? GunTurret {
                return
            }
            if let _ = event.entityA as? GunTurret, let _ = event.entityB as? Bullet {
                return
            }
            if let bullet = event.entityA as? Bullet, let hasHealth = event.entityB as? HasHealth {
                print("Collision Event Detected")
                if bullet == self {
                    self.animationController?.stop()
                    let bulletTransform = Transform()
                    self.transform = bulletTransform
                }
                hasHealth.damageToHealth(damagePoints: bullet.damagePoints)
            }
//            if let objectA = event.entityA as? Bullet {
//                print("A Is Bullet")
//            }
//            if let objectB = event.entityB as? Target {
//                print("B Is Target")
//            }
//            if let objectA = event.entityA as? Target {
//                print("A Is Target")
//            }
//            if let objectB = event.entityB as? Bullet {
//                print("B Is Bullet")
//            }
//            if let _ = event.entityA as? GunTurret {
//                print("A Is GunTurret")
//            }
//            if let _ = event.entityB as? GunTurret {
//                print("B Is GunTurret")
//            }
        })
        collisionSubscription = beginSubscription
    }
}

public protocol HasHealth {
    func damageToHealth(damagePoints: Int)
    func checkHealth()
}


