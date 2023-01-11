//
//  KakaoOAuthService.swift
//  PersonalScheduler
//
//  Created by minsson on 2023/01/12.
//

import Foundation
import KakaoSDKUser

final class KakaoOAuthService {
    
    func executeLogin() {
        if UserApi.isKakaoTalkLoginAvailable() {
            executeLoginWithKakaoTalk()
        } else {
            executeLoginWithKakaoAccount()
        }
    }
    
    private func executeLoginWithKakaoTalk() {
        UserApi.shared.loginWithKakaoTalk {oauthToken, error in
            guard error == nil else {
                print(error?.localizedDescription as Any)
                return
            }
            
            print("loginWithKakaoTalk() success.")
            
            _ = oauthToken
        }
    }
    
    private func executeLoginWithKakaoAccount() {
        UserApi.shared.loginWithKakaoAccount {oauthToken, error in
            guard error == nil else {
                print(error?.localizedDescription as Any)
                return
            }
            
            print("loginWithKakaoAccount() success.")
            
            _ = oauthToken
        }
    }
    
}
