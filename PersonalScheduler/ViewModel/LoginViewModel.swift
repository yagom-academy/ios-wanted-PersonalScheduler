//
//  LoginViewModel.swift
//  PersonalScheduler
//
//  Created by 써니쿠키 on 2023/02/07.
//

import Foundation
import KakaoSDKAuth
import KakaoSDKUser

final class LoginViewModel {
    private var userInfo: UserInfo? = nil
}

//MARK: - KakaoLogin
extension LoginViewModel {

    func kakaoLogin() {
        UserApi.isKakaoTalkLoginAvailable() ? loginWithApp() : loginWithAccount()
    }

    private func loginWithApp() {
        UserApi.shared.loginWithKakaoTalk {(_, error) in
            if let error = error {
                print(error)
            }
            else {
                self.fetchUserId()
            }
        }
    }

    private func loginWithAccount() {
        UserApi.shared.loginWithKakaoAccount {(_, error) in
            if let error = error {
                print(error)
            }
            else {
                self.fetchUserId()
            }
        }
    }

    private func fetchUserId() {
        UserApi.shared.me() {(user, error) in
            if let error = error {
                print(error)
            }
            guard let id = user?.id else { return }
            self.user = UserInfo(id: "kakao\(id)")
        }
    }
}
