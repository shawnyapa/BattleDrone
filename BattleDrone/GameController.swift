//
//  GameController.swift
//  ARExperiment3
//
//  Created by Shawn Yapa on 7/28/21.
//

import Foundation
import ARKit
import RealityKit
import OSLog

enum ARGameObjectType {
    case Target
    case Gun
    case Bullet
}

enum ARGameObjectStatus {
    case Request
    case Created
    case ActiveInScene
}

class GameObject {
    var imageName: String
    var gameObjectType: ARGameObjectType
    var arGameObjectStatus = ARGameObjectStatus.Request
    var entity: Entity?
    var anchor: AnchorEntity?
    
    init(imageName: String, gameObjectType: ARGameObjectType) {
        self.imageName = imageName
        self.gameObjectType = gameObjectType
    }
}

class GameController: NSObject {
    
    let arView = ARView(frame: CGRect())
    var gameObjects = [GameObject(imageName: "Prince1", gameObjectType: ARGameObjectType.Target), GameObject(imageName: "Prince2", gameObjectType: ARGameObjectType.Gun)]
            
    func layoutGameARView(forView view:UIView) {
        view.addSubview(self.arView)
        let margins = view.layoutMarginsGuide
        self.arView.translatesAutoresizingMaskIntoConstraints = false
        self.arView.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: 0).isActive = true
        self.arView.topAnchor.constraint(equalTo: margins.topAnchor, constant: 0).isActive = true
        self.arView.heightAnchor.constraint(equalTo: margins.heightAnchor, constant: 0).isActive = true
        self.arView.widthAnchor.constraint(equalTo: margins.widthAnchor, constant: 0).isActive = true
    }
    
    func startGame() {
        createARObjects()
        setupARConfigurationWithImageAnchors(arView: arView)
    }
    
    // MARK: ARObject Setups
    func createARObjects () {
        for gameObject in gameObjects {
            switch gameObject.gameObjectType {
            case .Gun:
                gameObject.entity = GunTurret()
                gameObject.arGameObjectStatus = .Created    // ***SY Add Async Completion on Status
            case .Target:
                gameObject.entity = Target()
                gameObject.arGameObjectStatus = .Created    // ***SY Add Async Completion on Status
            case .Bullet:
                gameObject.entity = Bullet()
                gameObject.arGameObjectStatus = .Created    // Should Not be Used as Bullet is not Primary
            }
        }
    }
    
    func setupARConfigurationWithImageAnchors(arView: ARView) {
        guard let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: nil) else {
            os_log("Unable to Load Images")
            return
        }
        let configuration = ARWorldTrackingConfiguration()
        configuration.detectionImages = referenceImages
        arView.session.delegate = self  // ***SY Temporary
        arView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    // MARK: ARObject Scene Placement
    func evaluateImageAnchorForGameObjectPlacementInARView(imageAnchor: ARImageAnchor, arView: ARView) {
        for gameObject in gameObjects {
            if imageAnchor.referenceImage.name == gameObject.imageName && gameObject.arGameObjectStatus == .Created {
                let anchorEntity = AnchorEntity(anchor: imageAnchor)
                if let gameObjectEntity = gameObject.entity {
                    anchorEntity.addChild(gameObjectEntity)
                    gameObject.anchor = anchorEntity
                    arView.scene.addAnchor(anchorEntity)
                    if gameObject.gameObjectType == .Gun {
                        if let gunTurret = gameObject.entity as? GunTurret {
                            gunTurret.anchorWeaponAndBullets(anchorEntity: anchorEntity)
                            gunTurret.setupFireControlForView(view: arView)
                        }
                    }
                }
            }
        }
    }
}

extension GameController: ARSessionDelegate {
    
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        // update to ARFrame
    }

    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        // didAdd ARAnchor
        for arAnchor in anchors {
            if let arImageAnchor = arAnchor as? ARImageAnchor {
            print("Found Image Anchor")
            evaluateImageAnchorForGameObjectPlacementInARView(imageAnchor: arImageAnchor, arView: arView)
            }
        }
    }
    
    func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
        // didUpdate ARAnchor
    }

    func session(_ session: ARSession, didRemove anchors: [ARAnchor]) {
        // didRemove ARAnchor
    }
    
}
