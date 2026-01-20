//
//  AppDelegate.swift
//  PinjamanKas
//
//  Created by hekang on 2026/1/20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow()
        window?.frame = UIScreen.main.bounds
        window?.rootViewController = LaunchViewController()
        window?.makeKeyAndVisible()
        
        return true
    }
    
    
}

