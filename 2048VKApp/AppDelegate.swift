//
//  AppDelegate.swift
//  2048VKApp
//
//  Created by Alisher Saideshov on 04.04.2024.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions 
                     launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow()
        window?.rootViewController = GameViewController()
        window?.makeKeyAndVisible()
        return true
    }
}

