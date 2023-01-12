//
//  LoginManager.swift
//  PersonalScheduler
//
//  Created by Judy on 2023/01/12.
//

import Foundation

final class LoginManager {
    private enum Login {
        static let userToken = "userToken"
    }
    
    static let shared = LoginManager()
    
    private init() { }
    
    func getUserToken() -> String? {
        if let userID = UserDefaults.standard.string(forKey: Login.userToken) {
            return userID
        }
        
        return nil
    }
    
    func saveUserToken(_ token: String?) {
        if let userToken = token {
           UserDefaults.standard.set(userToken, forKey: Login.userToken)
        }
    }
}
