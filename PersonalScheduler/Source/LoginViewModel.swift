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
        var kakaoToken: String?
        
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                guard error == nil else {
                    print(error)
                    return
                }
                print("loginWithKakaoTalk() success.")
                kakaoToken = oauthToken?.idToken
                self.configureKakaoSign(token: kakaoToken)
            }
        } else {
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                guard error == nil else {
                    print(error)
                    return
                }
                print("loginWithKakaoAccount() success.")
                kakaoToken = oauthToken?.idToken
                
                self.configureKakaoSign(token: kakaoToken)
            }
        }
    }
    
    private func configureKakaoSign(token: String?) {
        guard let token = token else { return }
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
