//
//  BaseViewController.swift
//  PinjamanKas
//
//  Created by hekang on 2026/1/20.
//

import UIKit

class BaseViewController: UIViewController {
    
    let languageCode = LanguageManager.shared.getLanguage()
    
    lazy var appHeadView: AppHeadView = {
        let appHeadView = AppHeadView(frame: .zero)
        return appHeadView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
}

extension BaseViewController {
    
    func pushWebVc(with pageUrl: String) {
        let webVc = H5WebViewController()
        webVc.pageUrl = pageUrl
        self.navigationController?.pushViewController(webVc, animated: true)
    }
    
}
