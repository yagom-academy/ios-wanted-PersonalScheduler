//
//  KeyChainStorage.swift
//  PersonalScheduler
//
//  Created by Ari on 2023/01/10.
//

import Foundation

enum KeyChinaKey: String {
    case accessToken = "accessToken"
    case refreshToken = "refreshToken"
}

protocol KeyChainStorageService: AnyObject {
    
    func read(_ key: KeyChinaKey) -> String?
    
    @discardableResult
    func write(key: KeyChinaKey, value: String) -> Bool
    
    @discardableResult
    func delete(key: KeyChinaKey) -> Bool
    
}

final class KeyChainStorage: KeyChainStorageService {
    
    static let shard = KeyChainStorage()
    
    private init() {}
    
    func read(_ key: KeyChinaKey) -> String? {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key.rawValue,
            kSecReturnAttributes: true,
            kSecReturnData: true
        ]
        
        var item: CFTypeRef?
        if SecItemCopyMatching(query as CFDictionary, &item) != errSecSuccess {
            return nil
        }
        guard let existingItem = item as? [String: Any] else {
            return nil
        }
        guard let data = existingItem[kSecValueData as String] as? Data else {
            return nil
        }
        guard let token = String(data: data, encoding: .utf8) else {
            return nil
        }
        
        return token
    }
    
    @discardableResult
    func write(key: KeyChinaKey, value: String) -> Bool {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key.rawValue,
            kSecValueData: value.data(using: .utf8)!
        ]
        
        SecItemDelete(query as CFDictionary)
        
        let status: OSStatus = SecItemAdd(query as CFDictionary, nil)
        return status == errSecSuccess
    }
    
    
    @discardableResult
    func delete(key: KeyChinaKey) -> Bool {
        let deleteQuery: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key.rawValue
        ]
        
        let status = SecItemDelete(deleteQuery)
        
        return status == errSecSuccess
    }
    
}
