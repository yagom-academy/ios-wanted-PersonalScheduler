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
            isSuccess.send(false)
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
                    self.isSuccess.send(false)
                    return
                }
                self.isSuccess.send(true)
            }
        }
        
        if UserApi.isKakaoTalkLoginAvailable() == false {
            UserApi.shared.loginWithKakaoAccount { token, error in
                guard error == nil else {
                    self.isSuccess.send(false)
                    return
                }
                self.isSuccess.send(true)
            }
        }
    }
    
    func readUserInformation() {
        UserApi.shared.me { user, error in
            if let error = error {
                self.isSuccess.send(false)
            } else {
                guard let email = user?.kakaoAccount?.email,
                      let id = user?.id else {
                    self.isSuccess.send(false)
                    return
                }
                
                self.isSuccess.send(true)
            }
        }
    }
}
