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
        if AuthApi.hasToken() {
            UserApi.shared.accessTokenInfo { accessTokenInfo, error in
                if let error = error {
                    print("카카오톡 토큰 가져오기 에러 \(error.localizedDescription)")
                    self.kakaoLogin()
                } else {
                    // 토큰 유효성 체크 성공 (필요 시 토큰 갱신)
                    self.setUserInfo()
                }
            }
        } else {
            kakaoLogin()
        }
    }
    
    private func kakaoLogin() {
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk { (oauthToken, error) in
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
        UserApi.shared.me() { (user, error) in
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
