//
//  BaseNavigationController.swift
//  PinjamanKas
//
//  Created by hekang on 2026/1/20.
//

import UIKit

class BaseNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.navigationBar.isHidden = true
        self.navigationBar.isTranslucent = false
        if let gestureRecognizers = view.gestureRecognizers {
            for gesture in gestureRecognizers {
                if let popGesture = gesture as? UIScreenEdgePanGestureRecognizer {
                    view.removeGestureRecognizer(popGesture)
                }
            }
        }
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if let tabVC = self.tabBarController as? MainTabBarController {
            tabVC.setCustomTabBar(hidden: true, animated: true)
        }
        super.pushViewController(viewController, animated: animated)
    }
    
}

extension BaseNavigationController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if let tabVC = self.tabBarController as? MainTabBarController {
            let isRoot = (viewController == navigationController.viewControllers.first)
            if isRoot {
                tabVC.setCustomTabBar(hidden: false, animated: true)
            }
        }
    }
}
