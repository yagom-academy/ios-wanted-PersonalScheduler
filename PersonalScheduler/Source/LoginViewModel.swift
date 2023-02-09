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
    func loginKakao(completion: @escaping ((String) -> Void)) {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                guard error == nil else {
                    print(error)
                    return
                }
                
                print("loginWithKakaoTalk() success.")
                guard let token = oauthToken?.idToken else { return }
                let credential = OAuthProvider.credential(
                    withProviderID: "oidc.kakao",
                    idToken: token,
                    rawNonce: nil
                )
                
                Auth.auth().signIn(with: credential) { authResult, error in
                    guard error == nil else {
                        print(error)
                        return
                    }
                }
            }
        } else {
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                guard error == nil else {
                    print(error)
                    return
                }
                
                print("loginWithKakaoAccount() success.")
                guard let token = oauthToken?.idToken else { return }
                let credential = OAuthProvider.credential(
                    withProviderID: "oidc.kakao",
                    idToken: token,
                    rawNonce: nil
                )
                
                Auth.auth().signIn(with: credential) { authResult, error in
                    guard error == nil else {
                        print(error)
                        return
                    }
                }
                
            }
        }
        
        // User Name 가져오기
        UserApi.shared.me { user, error in
            guard let user = user else { return }
            guard let nickName = user.kakaoAccount?.profile?.nickname else { return }
            completion(nickName)
        }
    }
    
    func faceBookLogin() {
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
                    return
                }
            }
        }
    }
    
    
    func appleLogin() {
        
    }
}
