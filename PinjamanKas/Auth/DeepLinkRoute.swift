//
//  DeepLinkRoute.swift
//  PinjamanKas
//
//  Created by hekang on 2026/1/20.
//

import UIKit

struct DeepLinkRoute {
    enum Path: String {
        case autumnLeaf
        case breezeSerenade
        case celestialDawn
        case dawnWhisper
        case eclipseShadow
    }
    
    let path: Path
    let queryParams: [String: String]
    static let scheme_url = "pinjamnyaman://pinjam.nyaman.app"
    
    init?(url: URL) {
        guard url.scheme == "pinjamnyaman",
              url.host == "pinjam.nyaman.app" else {
            return nil
        }
        
        let pathString = url.path.trimmingCharacters(in: CharacterSet(charactersIn: "/"))
        guard let path = Path(rawValue: pathString) else {
            return nil
        }
        
        self.path = path
        
        var params: [String: String] = [:]
        if let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
           let queryItems = components.queryItems {
            for item in queryItems {
                params[item.name] = item.value
            }
        }
        self.queryParams = params
    }
}

class URLSchemeRouter {
    
    static func handle(pageURL: String, from vc: BaseViewController) {
        guard let url = URL(string: pageURL),
              let route = DeepLinkRoute(url: url) else {
            return
        }
        
        switch route.path {
        case .autumnLeaf:
            let settingVc = SettingViewController()
            vc.navigationController?.pushViewController(settingVc, animated: true)
            
        case .eclipseShadow:
            let productVc = ProductViewController()
            productVc.productID = route.queryParams["rival"] ?? ""
            vc.navigationController?.pushViewController(productVc, animated: true)
            
        case .breezeSerenade:
            break
            
        case .dawnWhisper:
            break
            
        case .celestialDawn:
            break
        }
    }
}
