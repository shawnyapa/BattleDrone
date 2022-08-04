//
//  AppDelegate.swift
//  BattleDrone
//
//  Created by Shawn Yapa on 8/2/21.
//

import UIKit

//TODO: ***SY
// Add Persistence Layer (protocol based) - DONE
// Add Game Ended Workflow
// Add App Icon, Min Graphics, Game Instruction Info Labels, ReadMe Details on GitHub
// Clean up HasWeapon Protocol, add HasMoveableWeapon Protocol
// Add Check to prevent over-rotation in the Y direction on GunTurret
// Extend Bullet travel distance, destroy on plane collison, recycle bullets
// Add Score, Status Overlay (GameStatusView)
// Calculate Scores, Persist Scores
// Add Top Scores Display UX
// Add Interface Stubs for Airtag API with LocationAnchors

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

