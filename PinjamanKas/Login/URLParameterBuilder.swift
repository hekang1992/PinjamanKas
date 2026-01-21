//
//  URLParameterBuilder.swift
//  PinjamanKas
//
//  Created by hekang on 2026/1/20.
//


import UIKit

struct URLParameterBuilder {
    
    struct Keys {
        static let platform = "bright"
        static let appVersion = "blocked"
        static let deviceName = "narro"
        static let idfv1 = "shrug"
        static let osVersion = "fatalistic"
        static let market = "marl"
        static let sessionId = "speculatively"
        static let idfv2 = "glitter"
        static let language = "petes"
    }
    
    static func getCommonParameters() -> [String: String] {
        let info = Bundle.main.infoDictionary
        let appVersion = info?["CFBundleShortVersionString"] as? String ?? "1.0.0"
        let osVersion = UIDevice.current.systemVersion
        let deviceName = UIDevice.current.model
        let idfv = KeychainHelper.shared.getDeviceIDFV()
        
        var params: [String: String] = [
            Keys.platform: "ios",
            Keys.appVersion: appVersion,
            Keys.deviceName: deviceName,
            Keys.idfv1: idfv,
            Keys.idfv2: idfv,
            Keys.osVersion: osVersion,
            Keys.market: "apptrore-pjny",
//            Keys.language: LanguageManager.shared.getLanguage()
            Keys.language: "762"
        ]
        
        if let session = UserManager.shared.getToken() {
            params[Keys.sessionId] = session
        }
        
        return params
    }
    
    static func appendParams(to urlString: String) -> String {
        let params = getCommonParameters()
        var components = URLComponents(string: urlString)
        
        let queryItems = params.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        if components?.queryItems == nil {
            components?.queryItems = queryItems
        } else {
            components?.queryItems?.append(contentsOf: queryItems)
        }
        
        return components?.url?.absoluteString ?? urlString
    }
}
