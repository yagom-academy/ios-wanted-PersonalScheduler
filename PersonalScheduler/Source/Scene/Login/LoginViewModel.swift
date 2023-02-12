//
//  LoginViewModel.swift
//  PersonalScheduler
//
//  Created by Kyo on 2023/02/07.
//

import Foundation
import KakaoSDKAuth
import KakaoSDKUser
import FacebookLogin
import FirebaseAuth

final class LoginViewModel {
    func loginKakao(completion: @escaping (Bool) -> Void) {
        var kakaoToken: String?
        
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                guard error == nil else {
                    print(error)
                    return
                }
                kakaoToken = oauthToken?.idToken
                self.configureKakaoSign(token: kakaoToken) { result in
                    if result {
                        completion(true)
                    } else {
                        completion(false)
                    }
                }
            }
        } else {
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                guard error == nil else {
                    print(error)
                    return
                }
                kakaoToken = oauthToken?.idToken
                self.configureKakaoSign(token: kakaoToken) { result in
                    if result {
                        completion(true)
                    } else {
                        completion(false)
                    }
                }
            }
        }
    }
    
    private func configureKakaoSign(token: String?, completion: @escaping (Bool) -> Void) {
        guard let token = token else { return }
        let credential = OAuthProvider.credential(
            withProviderID: "oidc.kakao",
            idToken: token,
            rawNonce: nil
        )
        
        Auth.auth().signIn(with: credential) { authResult, error in
            guard error == nil else {
                print(error)
                completion(false)
                return
            }
            completion(true)
        }
    }
    
    func faceBookLogin(completion: @escaping (Bool) -> Void) {
        let loginManager = LoginManager()
        
        loginManager.logIn(permissions: ["public_profile"], from: nil) { result, error in
            guard error == nil else {
                print("Encountered Erorr: \(String(describing: error))")
                return
            }
            
            guard let result = result, !result.isCancelled else {
                print("Cancelled")
                return
            }
            
            guard let token = result.token else { return }
            let credential = FacebookAuthProvider.credential(withAccessToken: token.tokenString)
            
            Auth.auth().signIn(with: credential) { authResult, error in
                guard error == nil else {
                    print(error)
                    completion(false)
                    return
                }
                completion(true)
            }
        }
    }
}
