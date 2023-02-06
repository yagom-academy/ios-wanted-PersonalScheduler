//
//  LoginViewModel.swift
//  PersonalScheduler
//
//  Copyright (c) 2023 Minii All rights reserved.

import KakaoSDKAuth
import KakaoSDKUser
import KakaoSDKCommon
import Combine
import FirebaseAuth

class LoginViewModel {
    func loginKakao() {
        if AuthApi.hasToken() {
            UserApi.shared.accessTokenInfo { [weak self] _, error in
                guard let self = self else { return }
                
                if let error = error {
                    if let sdkError = error as? SdkError,
                       sdkError.isInvalidTokenError() == true {
                        self.authorizationKakao()
                    } else {
                        print("error in login Kakao")
                    }
                } else {
                    self.readUserInformation()
                }
            }
        } else {
            authorizationKakao()
        }
    }
    
    func authorizationKakao() {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk { token, error in
                if let error = error {
                    print("Error in user api : \(error)")
                } else {
                    self.readUserInformation()
                }
            }
        } else {
            UserApi.shared.loginWithKakaoAccount { token, error in
                if let error = error {
                    print("Error in user api in kakao Account : \(error)")
                } else {
                    self.readUserInformation()
                }
            }
        }
    }
    
    func readUserInformation() {
        UserApi.shared.me { user, error in
            if let error = error {
                print("Error in get user information : \(error)")
            } else {
                guard let email = user?.kakaoAccount?.email,
                      let id = user?.id else {
                    return
                }
                
                self.createFirUser(id: email, password: id.description)
            }
        }
    }
    
    func createFirUser(id: String, password: String) {
        // TODO: - Open ID Connect
    }
}
