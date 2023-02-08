//
//  KakaoService.swift
//  PersonalScheduler
//
//  Copyright (c) 2023 Minii All rights reserved.

import Combine
import Foundation
import FirebaseAuth
import KakaoSDKAuth
import KakaoSDKCommon
import KakaoSDKUser

final class KakaoLoginService: LoginService {
    var isSuccess: PassthroughSubject<Bool, Never> = PassthroughSubject()
    
    func login() -> AnyPublisher<Bool, Never> {
        if AuthApi.hasToken() == true {
            UserApi.shared.accessTokenInfo { _, error in
                guard error == nil else {
                    self.handleTokenError(error: error)
                    return
                }
                self.authorizationKakao()
            }
        }
        
        if AuthApi.hasToken() == false {
            self.authorizationKakao()
        }
        
        return isSuccess.eraseToAnyPublisher()
    }
    
    private func tokenHandle() {
        UserApi.shared.accessTokenInfo { _, error in
            guard error == nil else {
                self.handleTokenError(error: error)
                return
            }
            
            self.authorizationKakao()
        }
    }
    
    private func handleTokenError(error: Error?) {
        guard let error = error as? SdkError else {
            isSuccess.send(false)
            return
        }
        
        if error.isInvalidTokenError() {
            authorizationKakao()
        }
    }
    
    private func authorizationKakao() {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk(completion: handleToken)
        }
        
        if UserApi.isKakaoTalkLoginAvailable() == false {
            UserApi.shared.loginWithKakaoAccount(completion: handleToken)
        }
    }
    
    private func handleToken(token: OAuthToken?, error: Error?) {
        guard error == nil,
              let idToken = token?.idToken else {
            self.isSuccess.send(false)
            return
        }
        
        loginFirebase(token: idToken)
    }
    
    func loginFirebase(token: String) {
        let credential = OAuthProvider.credential(
            withProviderID: "oidc.kakao",
            idToken: token,
            rawNonce: nil
        )
        
        Auth.auth().signIn(with: credential) { result, error in
            guard error == nil else {
                self.isSuccess.send(false)
                return
            }
            
            self.isSuccess.send(true)
        }
    }
}
