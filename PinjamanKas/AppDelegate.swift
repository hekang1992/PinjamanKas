//
//  AppDelegate.swift
//  PinjamanKas
//
//  Created by hekang on 2026/1/20.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        noti()
        window = UIWindow()
        window?.frame = UIScreen.main.bounds
        window?.rootViewController = LaunchViewController()
        window?.makeKeyAndVisible()
        return true
    }
    
}

extension AppDelegate {
    
    private func noti() {
        NotificationCenter.default.addObserver(self, selector: #selector(changeRootVc), name: Notification.Name("changeRootVc"), object: nil)
    }
    
    @objc private func changeRootVc() {
        window?.rootViewController = MainTabBarController()
    }
}
