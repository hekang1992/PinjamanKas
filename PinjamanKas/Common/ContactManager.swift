//
//  ContactManager.swift
//  PinjamanKas
//
//  Created by hekang on 2026/1/21.
//

import UIKit
import Contacts
import ContactsUI

typealias ContactResult = ([[String: String]]) -> Void

class ContactManager: NSObject {
    
    static let shared = ContactManager()
    
    private let contactStore = CNContactStore()
    private var singleSelectCallback: ContactResult?
    
    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        let status = CNContactStore.authorizationStatus(for: .contacts)
        
        switch status {
        case .authorized, .limited:
            completion(true)
            
        case .notDetermined:
            contactStore.requestAccess(for: .contacts) { granted, _ in
                DispatchQueue.main.async {
                    completion(granted)
                }
            }
            
        case .denied, .restricted:
            completion(false)
            
        @unknown default:
            completion(false)
        }
    }
    
    func selectSingleContact(from vc: UIViewController,
                             completion: @escaping ContactResult) {
        
        requestAuthorization { granted in
            if !granted {
                self.showSettingAlert(on: vc)
                return
            }
            
            self.singleSelectCallback = completion
            
            let picker = CNContactPickerViewController()
            picker.delegate = self
            picker.displayedPropertyKeys = [
                CNContactGivenNameKey,
                CNContactFamilyNameKey,
                CNContactPhoneNumbersKey
            ]
            
            vc.present(picker, animated: true)
        }
    }
    
    func fetchAllContacts(completion: @escaping ContactResult) {
        
        requestAuthorization { granted in
            if !granted {
                completion([])
                return
            }
            
            var result: [[String: String]] = []
            
            let keys: [CNKeyDescriptor] = [
                CNContactGivenNameKey as CNKeyDescriptor,
                CNContactFamilyNameKey as CNKeyDescriptor,
                CNContactPhoneNumbersKey as CNKeyDescriptor
            ]
            
            let request = CNContactFetchRequest(keysToFetch: keys)
            
            try? self.contactStore.enumerateContacts(with: request) { contact, _ in
                
                let name = contact.givenName + " " + contact.familyName
                let phones = contact.phoneNumbers
                    .map { $0.value.stringValue }
                    .joined(separator: ",")
                
                if !phones.isEmpty {
                    result.append([
                        "bulging": phones,
                        "steering": name
                    ])
                }
            }
            
            completion(result)
        }
    }
    
    private func showSettingAlert(on vc: UIViewController) {
        let alert = UIAlertController(
            title: "通讯录权限未开启",
            message: "请前往设置开启通讯录权限",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "取消", style: .cancel))
        alert.addAction(UIAlertAction(title: "去设置", style: .default) { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url)
            }
        })
        
        vc.present(alert, animated: true)
    }
}

// MARK: - CNContactPickerDelegate
extension ContactManager: CNContactPickerDelegate {
    
    func contactPicker(_ picker: CNContactPickerViewController,
                       didSelect contact: CNContact) {
        
        let name = contact.givenName + " " + contact.familyName
        let phone = contact.phoneNumbers.first?.value.stringValue ?? ""
        
        let result = [[
            "bulging": phone,
            "steering": name
        ]]
        
        singleSelectCallback?(result)
    }
}
