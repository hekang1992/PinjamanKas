//
//  MainTabBarController.swift
//  PinjamCepat
//
//  Created by Emma Johnson on 2026/1/20.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewControllers()
        setupTabBarAppearance()
    }
    
    private func setupViewControllers() {
        let homeVC = HomeViewController()
        homeVC.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(named: "home_nor")?.withRenderingMode(.alwaysOriginal),
            selectedImage: UIImage(named: "home_sel")?.withRenderingMode(.alwaysOriginal)
        )
        homeVC.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        let homeNav = BaseNavigationController(rootViewController: homeVC)
        
        let centerVC = CenterViewController()
        centerVC.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(named: "center_nor")?.withRenderingMode(.alwaysOriginal),
            selectedImage: UIImage(named: "center_sel")?.withRenderingMode(.alwaysOriginal)
        )
        centerVC.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        let centerNav = BaseNavigationController(rootViewController: centerVC)
        
        self.viewControllers = [homeNav, centerNav]
    }
    
    private func setupTabBarAppearance() {
        tabBar.isTranslucent = false
        tabBar.backgroundColor = .white
        self.delegate = self
    }
    
}

extension MainTabBarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if !UserManager.shared.isLogin {
            let navc = BaseNavigationController(rootViewController: LoginViewController())
            navc.modalPresentationStyle = .overFullScreen
            self.present(navc, animated: true)
            return false
        }
        return true
    }
    
    
}
