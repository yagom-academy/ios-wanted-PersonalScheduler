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

class LoginManager {
    static let shared = LoginManager()
    
    func kakaoLogin() {
        if AuthApi.hasToken() {
            UserApi.shared.accessTokenInfo { tokenInfo, error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    self.loginFirebase()
                }
            }
        } else {
            if (UserApi.isKakaoTalkLoginAvailable()) {
                UserApi.shared.loginWithKakaoTalk { (token, error) in
                    if let error = error {
                        print(error.localizedDescription)
                    } else {
                        self.loginFirebase()
                    }
                }
            } else {
                UserApi.shared.loginWithKakaoAccount { oauthToken, error in
                        if let error = error {
                            print(error.localizedDescription)
                        } else {
                            self.loginFirebase()
                        }
                    }
            }
        }
    }
    
    private func loginFirebase() {
        UserApi.shared.me() { user, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                Auth.auth().createUser(withEmail: (user?.kakaoAccount?.email)!,
                                       password: "\(String(describing: user?.id))") { result, error in
                    if let error = error {
                        Auth.auth().signIn(withEmail: (user?.kakaoAccount?.email)!,
                                           password: "\(String(describing: user?.id))")
                        print(error.localizedDescription)
                    } else {
                        UserManager.shared.createUser(email: (user?.kakaoAccount?.email)!, name: (user?.kakaoAccount?.profile?.nickname)!)
                    }
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
