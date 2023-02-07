//  PersonalScheduler - LoginViewModel.swift
//  Created by zhilly on 2023/02/07

import Foundation
import KakaoSDKAuth
import KakaoSDKUser

final class LoginViewModel {
    
    // MARK: - Properties
    
    var userInfo: Observable<String?> = Observable(.init())
    
    // MARK: - Methods
    
    func tappedKakaoLoginButton() {
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoTalk() success.")
                    
                    _ = oauthToken
                    
                    // TODO: 발급받은 Token 관리
                    //let accessToken = oauthToken?.accessToken
                    
                    self.setUserInfo()
                }
            }
        }
    }
    
    private func setUserInfo() {
        UserApi.shared.me() {(user, error) in
            if let error = error {
                print(error)
            }
            else {
                print("me() success.")
                _ = user
                self.userInfo.value = user?.kakaoAccount?.profile?.nickname
            }
        }
    }
}
