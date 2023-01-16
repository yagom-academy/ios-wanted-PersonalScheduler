//
//  LoginManager.swift
//  PersonalScheduler
//
//  Created by 정재근 on 2023/01/09.
//

import Foundation
import KakaoSDKUser
import KakaoSDKAuth
import FirebaseAuth

class KakaoLoginManager {
    static let shared = KakaoLoginManager()
    
    private func hasTokenLogin(_ completion: @escaping (Error?) -> Void) {
        UserApi.shared.accessTokenInfo { tokenInfo, error in
            if let error {
                completion(error)
            } else {
                FirebaseLoginManager.shared.loginFirebaseForKakao() { error in
                    completion(error)
                }
            }
        }
    }
    
    private func appLogin(_ completion: @escaping (Error?) -> Void) {
        UserApi.shared.loginWithKakaoTalk { (token, error) in
            if let error {
                completion(error)
            } else {
                FirebaseLoginManager.shared.loginFirebaseForKakao() {error in
                completion(error)
                }
            }
        }
    }
    
    private func webLogin(_ completion: @escaping (Error?) -> Void) {
        UserApi.shared.loginWithKakaoAccount { oauthToken, error in
                if let error {
                    completion(error)
                } else {
                    FirebaseLoginManager.shared.loginFirebaseForKakao() { error in
                    completion(error)
                }
            }
        }
    }
    
    func login(_ completion: @escaping (Error?) -> Void) {
        if AuthApi.hasToken() {
            self.hasTokenLogin() { error in
                completion(error)
            }
        } else {
            if (UserApi.isKakaoTalkLoginAvailable()) {
                self.appLogin() { error in
                    completion(error)
                }
            } else {
                self.webLogin() { error in
                    completion(error)
                }
            }
        }
    }
    
    func logout() {
        UserApi.shared.logout { error in
            UserApi.shared.unlink { error in
                try! Auth.auth().signOut()
            }
        }
    }
}
