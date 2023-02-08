//
//  KakaoService.swift
//  PersonalScheduler
//
//  Copyright (c) 2023 Minii All rights reserved.

import Combine
import Foundation
import KakaoSDKAuth
import KakaoSDKCommon
import KakaoSDKUser

final class KakaoLoginService: LoginService {
    var isSuccess: PassthroughSubject<Bool, Never> = PassthroughSubject()
    
    func login() {
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
        guard error == nil else {
            self.isSuccess.send(false)
            return
        }
        
        readUserInformation()
    }
    
    private func readUserInformation() {
        UserApi.shared.me { user, error in
            guard error == nil,
                  let email = user?.kakaoAccount?.email,
                  let id = user?.id else {
                self.isSuccess.send(false)
                return
            }
            
            // TODO: - Firebase User Create
        }
    }
}
