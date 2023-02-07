//
//  LoginViewModel.swift
//  PersonalScheduler
//
//  Created by Kyo on 2023/02/07.
//

import Foundation
import KakaoSDKAuth
import KakaoSDKUser

final class LoginViewModel {
    func loginKakao() {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                    return
                }
                else {
                    print("loginWithKakaoTalk() success.")
                    _ = oauthToken
                }
            }
        } else {
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                if let error = error {
                    print(error)
                    return
                }
                else {
                    print("loginWithKakaoAccount() success.")
                    _ = oauthToken
                }
            }
        }
        
        UserApi.shared.me { user, error in
            print("🔥")
            print(user?.properties?["nickname"])
            print(user?.properties?["profile_image"])
        }
    }
}
