//
//  KeychainHelper.swift
//  PinjamanKas
//
//  Created by hekang on 2026/1/20.
//

import UIKit
import Foundation
import Security
import AppTrackingTransparency
import AdSupport

class KeychainHelper {
    
    static let shared = KeychainHelper()
    private let service = "app.pinjamankas.keychain.service"
    private let account = "app.pinjamankas.device.idfv"
    
    func getIDFA() -> String {
        let manager = ASIdentifierManager.shared()
        
        let idfa = manager.advertisingIdentifier.uuidString
        
        if idfa == "00000000-0000-0000-0000-000000000000" {
            return ""
        }
        
        return idfa
    }

    func getDeviceIDFV() -> String {
        if let savedIDFV = read(service: service, account: account) {
            return savedIDFV
        }
        
        let newIDFV = UIDevice.current.identifierForVendor?.uuidString ?? UUID().uuidString
        
        save(newIDFV, service: service, account: account)
        return newIDFV
    }

    private func save(_ data: String, service: String, account: String) {
        let data = data.data(using: .utf8)!
        let query = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecValueData as String: data
        ] as [String: Any]

        SecItemDelete(query as CFDictionary)
        SecItemAdd(query as CFDictionary, nil)
    }

    private func read(service: String, account: String) -> String? {
        let query = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ] as [String: Any]

        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)

        if status == errSecSuccess, let data = dataTypeRef as? Data {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
}
