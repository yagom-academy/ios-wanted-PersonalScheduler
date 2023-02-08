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
    @Published var isSuccess = false
    func authorization() -> AnyPublisher<Bool, Never> {
        login()
        return AnyPublisher($isSuccess)
    }
    
    func login() {
        if AuthApi.hasToken() {
            UserApi.shared.accessTokenInfo { _, error in
                guard error == nil else {
                    self.handleTokenError(error: error)
                    return
                }
                self.loginKakao()
            }
        } else {
            self.loginKakao()
        }
    }
    
    func handleTokenError(error: Error?) {
        guard let error = error as? SdkError else {
            isSuccess = false
            return
        }
        
        if error.isInvalidTokenError() {
            loginKakao()
        }
    }
    
    func loginKakao() {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk { token, error in
                guard error == nil else {
                    self.isSuccess = false
                    return
                }
                self.isSuccess = true
            }
        }
        
        if UserApi.isKakaoTalkLoginAvailable() == false {
            UserApi.shared.loginWithKakaoAccount { token, error in
                guard error == nil else {
                    self.isSuccess = false
                    return
                }
                self.isSuccess = true
            }
        }
    }
    
    func readUserInformation() {
        UserApi.shared.me { user, error in
            if let error = error {
                self.isSuccess = false
            } else {
                guard let email = user?.kakaoAccount?.email,
                      let id = user?.id else {
                    self.isSuccess = false
                    return
                }
                
                self.isSuccess = true
            }
        }
    }
}
