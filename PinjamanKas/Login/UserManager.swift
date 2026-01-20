//
//  UserManager.swift
//  PinjamanKas
//
//  Created by hekang on 2026/1/20.
//

import Foundation

class UserManager {
    
    static let shared = UserManager()
    private init() {}
    
    private let kUserToken = "com.app.userToken"
    private let kUserPhone = "com.app.userPhone"
    
    func saveLoginInfo(phone: String, token: String) {
        UserDefaults.standard.set(token, forKey: kUserToken)
        UserDefaults.standard.set(phone, forKey: kUserPhone)
        UserDefaults.standard.synchronize()
    }
    
    var isLogin: Bool {
        if let token = getToken(), !token.isEmpty {
            return true
        }
        return false
    }
    
    func getToken() -> String? {
        return UserDefaults.standard.string(forKey: kUserToken)
    }
    
    func getPhone() -> String? {
        return UserDefaults.standard.string(forKey: kUserPhone)
    }
    
    func clearLoginInfo() {
        UserDefaults.standard.removeObject(forKey: kUserToken)
        UserDefaults.standard.removeObject(forKey: kUserPhone)
        UserDefaults.standard.synchronize()
    }
}

class LanguageManager {
    
    static let shared = LanguageManager()
    private init() {}
    
    private let kUserLanguage = "com.app.userLanguage"
    
    func saveLanguageInfo(petes: String) {
        UserDefaults.standard.set(petes, forKey: kUserLanguage)
        UserDefaults.standard.synchronize()
    }
    
    func getLanguage() -> String {
        return UserDefaults.standard.string(forKey: kUserLanguage) ?? "762"
    }
    
}
