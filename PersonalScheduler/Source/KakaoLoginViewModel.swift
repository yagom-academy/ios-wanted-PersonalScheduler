//
//  KakaoLoginViewModel.swift
//  PersonalScheduler
//
//  Created by Kyo on 2023/02/07.
//

import Foundation
import KakaoSDKAuth
import KakaoSDKUser

final class KakaoLoginViewModel {
    func loginKakao() {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
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
                }
                else {
                    print("loginWithKakaoAccount() success.")
                    //do something
                    _ = oauthToken
                }
            }
        }
    }
}
