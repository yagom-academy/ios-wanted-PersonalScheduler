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

enum LoginResult {
    case loginSuccess
    case loginFail
}

class KakaoLoginManager {
    static let shared = KakaoLoginManager()
    
    private func hasTokenLogin(_ completion: @escaping (LoginResult, Error?) -> Void) {
        UserApi.shared.accessTokenInfo { tokenInfo, error in
            if let error {
                completion(LoginResult.loginFail, error)
            } else {
                self.loginFirebase() { result, error in
                    completion(result, error)
                }
            }
        }
    }
    
    private func appLogin(_ completion: @escaping (LoginResult, Error?) -> Void) {
        UserApi.shared.loginWithKakaoTalk { (token, error) in
            if let error {
                completion(LoginResult.loginFail, error)
            } else {
                self.loginFirebase() { result, error in
                completion(result, error)
                }
            }
        }
    }
    
    private func webLogin(_ completion: @escaping (LoginResult, Error?) -> Void) {
        UserApi.shared.loginWithKakaoAccount { oauthToken, error in
                if let error {
                    completion(LoginResult.loginFail, error)
                } else {
                    self.loginFirebase() { result, error in
                    completion(result, error)
                }
            }
        }
    }
    
    func login(_ completion: @escaping (LoginResult, Error?) -> Void) {
        if AuthApi.hasToken() {
            self.hasTokenLogin() { result, error in
                completion(result, error)
            }
        } else {
            if (UserApi.isKakaoTalkLoginAvailable()) {
                self.appLogin() { appLoginResult, error in
                    completion(appLoginResult, error)
                }
            } else {
                self.webLogin() { webLoginResult, error in
                    completion(webLoginResult, error)
                }
            }
        }
    }
    // 나중에 분리해야함
    private func loginFirebase(_ completion: @escaping (LoginResult, Error?) -> Void) {
        UserApi.shared.me() { user, error in
            if let error {
                completion(LoginResult.loginFail, error)
            } else {
                Auth.auth().createUser(withEmail: (user?.kakaoAccount?.email)!,
                                       password: "\(String(describing: user?.id))") { result, error in
                    if let error {
                        Auth.auth().signIn(withEmail: (user?.kakaoAccount?.email)!,
                                           password: "\(String(describing: user?.id))")
                        completion(LoginResult.loginFail, error)
                    } else {
                        UserManager.shared.createUser(email: (user?.kakaoAccount?.email)!, name: (user?.kakaoAccount?.profile?.nickname)!) { result, error in
                            if let error {
                                completion(LoginResult.loginFail, error)
                            } else {
                                completion(LoginResult.loginSuccess, nil)
                            }
                        }
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
