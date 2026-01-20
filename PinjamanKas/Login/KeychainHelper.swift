//
//  KeychainHelper.swift
//  PinjamanKas
//
//  Created by hekang on 2026/1/20.
//

import UIKit
import Foundation
import Security

class KeychainHelper {
    
    static let shared = KeychainHelper()
    private let service = "com.app.keychain.service"
    private let account = "com.app.device.idfv"

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

        SecItemDelete(query as CFDictionary) // 删掉旧的
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
