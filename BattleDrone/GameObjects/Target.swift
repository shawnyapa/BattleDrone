//
//  Target.swift
//  ARExperiment3
//
//  Created by Shawn Yapa on 5/26/21.
//

import Foundation
import RealityKit
import UIKit

class Target: Entity, HasModel, HasCollision {
    var healthPoints: Int = 50
    let color = UIColor.red
    let size:Float = 0.10
    let anchorImageName = "Prince1"
    
    required init() {
        super.init()
        let meshResource = MeshResource.generateSphere(radius: size)
        let materialResource = SimpleMaterial(color: color, isMetallic: false)
        self.components[ModelComponent] = ModelComponent(mesh: meshResource, materials: [materialResource])
        self.components[CollisionComponent] = CollisionComponent(shapes: [ShapeResource.generateSphere(radius: size)], mode: .trigger, filter: .sensor) // Testing .sensor
    }
}

extension Target: HasHealth {

    func damageToHealth(damagePoints: Int) {
        healthPoints = healthPoints-damagePoints
        checkHealth()
    }
    
    func checkHealth(){
        if healthPoints<=0 {
            isEnabled = false
        }
    }
}
