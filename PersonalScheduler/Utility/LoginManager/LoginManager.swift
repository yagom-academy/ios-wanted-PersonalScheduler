//
//  LoginManager.swift
//  PersonalScheduler
//
//  Created by Judy on 2023/01/12.
//

import Foundation
import FirebaseAuth



final class LoginManager {
    private enum Login {
        static let userID = "id"
        static let userPassword = "password"
        static let loginType = "loginType"
    }
    
    private enum LoginType: String {
        case kakao
        case facebook
    }
    
    static let shared = LoginManager()
    
    private init() { }
    
    func login() -> String? {
        guard let loginValue = UserDefaults.standard.string(forKey: Login.loginType),
              let loginType = LoginType(rawValue: loginValue) else {
            return nil
        }
        
        switch loginType {
        case .kakao:
            return loginWithKakao()
        case .facebook:
            return loginWithFacebook()
        }
    }
    
    func saveKakaoLogin(id: String, password: String) {
        UserDefaults.standard.set(LoginType.kakao.rawValue, forKey: Login.loginType)
        UserDefaults.standard.set(id, forKey: Login.userID)
        UserDefaults.standard.set(password, forKey: Login.userPassword)
    }
    
    func saveFacebookLogin(id: String, password: String) {
        UserDefaults.standard.set(LoginType.facebook, forKey: Login.loginType)
        UserDefaults.standard.set(id, forKey: Login.userID)
        UserDefaults.standard.set(password, forKey: Login.userPassword)
    }
    
    private func loginWithKakao() -> String? {
        guard let email = UserDefaults.standard.string(forKey: Login.userID),
              let password = UserDefaults.standard.string(forKey: Login.userPassword) else {
            return nil
        }
        
        Auth.auth().signIn(withEmail: email,
                           password: password) { result, error in
            if error != nil {
                return
            }
        }
        
        guard let user = Auth.auth().currentUser else { return nil }
        return user.uid
    }
    
    private func loginWithFacebook() -> String {
        return ""
    }
}
