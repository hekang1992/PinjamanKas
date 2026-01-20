//
//  MainTabBarController.swift
//  PinjamanKas
//
//  Created by hekang on 2026/1/20.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    private let customBar = UIView()
    private var buttons: [UIButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.isHidden = true
        
        setupViewControllers()
        setupCustomBar()
    }
    
    private func setupViewControllers() {
        let homeVC = HomeViewController()
        let homeNav = BaseNavigationController(rootViewController: homeVC)
        
        let centerVC = CenterViewController()
        let centerNav = BaseNavigationController(rootViewController: centerVC)
        
        self.viewControllers = [homeNav, centerNav]
    }
    
    private func setupCustomBar() {
        customBar.backgroundColor = .black
        customBar.layer.cornerRadius = 27
        customBar.clipsToBounds = true
        view.addSubview(customBar)
        
        customBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            customBar.widthAnchor.constraint(equalToConstant: 330),
            customBar.heightAnchor.constraint(equalToConstant: 54),
            customBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            customBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
        
        let images = [("home_nor", "home_sel"), ("center_nor", "center_sel")]
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        customBar.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: customBar.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: customBar.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: customBar.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: customBar.trailingAnchor)
        ])
        
        for (index, imgPair) in images.enumerated() {
            let btn = UIButton()
            btn.setImage(UIImage(named: imgPair.0), for: .normal)
            btn.setImage(UIImage(named: imgPair.1), for: .selected)
            btn.tag = index
            btn.addTarget(self, action: #selector(tabBarItemTapped(_:)), for: .touchUpInside)
            stackView.addArrangedSubview(btn)
            buttons.append(btn)
            
            if index == 0 { btn.isSelected = true }
        }
    }
    
    @objc private func tabBarItemTapped(_ sender: UIButton) {
        if !UserManager.shared.isLogin {
            let navc = BaseNavigationController(rootViewController: LoginViewController())
            navc.modalPresentationStyle = .overFullScreen
            self.present(navc, animated: true)
            return
        }
        self.selectedIndex = sender.tag
        buttons.forEach { $0.isSelected = ($0 == sender) }
    }
    
    func setCustomTabBar(hidden: Bool, animated: Bool) {
        let duration = animated ? 0.2 : 0
        UIView.animate(withDuration: duration) {
            self.customBar.alpha = hidden ? 0 : 1
        }
    }
}
