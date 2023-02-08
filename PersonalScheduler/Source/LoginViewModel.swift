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
    func loginKakao(completion: @escaping ((String, String?) -> Void)) {
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
            guard let user = user else { return }
//            print(user.properties?["nickname"])
//            print(user.properties?["profile_image"])
            guard let nickName = user.kakaoAccount?.profile?.nickname else { return }
            let email = user.kakaoAccount?.email
            
            completion(nickName, email)
        }
    }
}
