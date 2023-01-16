//
//  LocalStorage.swift
//  PersonalScheduler
//
//  Created by Ari on 2023/01/10.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

enum LocalKey: String {
    case userInfo
}

protocol LocalStorageService: AnyObject {
    func read(key: LocalKey) -> String?
    func write(key: LocalKey, value: String)
    func delete(key: LocalKey)
    func saveUser(_ user: User)
    func getUser() -> User?
}

extension UserDefaults: LocalStorageService {
    func read(key: LocalKey) -> String? {
        return Self.standard.object(forKey: key.rawValue) as? String
    }
    
    func write(key: LocalKey, value: String) {
        Self.standard.setValue(value, forKey: key.rawValue)
        Self.standard.synchronize()
    }
    
    func delete(key: LocalKey) {
        Self.standard.setValue(nil, forKey: key.rawValue)
        Self.standard.synchronize()
    }
    
    func saveUser(_ user: User) {
        let encoder = Firestore.Encoder()
        let encodedUser = try? encoder.encode(user)
        Self.standard.setValue(encodedUser, forKey: LocalKey.userInfo.rawValue)
        Self.standard.synchronize()
    }
    
    func getUser() -> User? {
        if let dictionary = Self.standard.object(forKey: LocalKey.userInfo.rawValue) as? [String: Any] {
            return User(dictionary)
            
        }
        return nil
    }
}
