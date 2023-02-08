//
//  LoginViewModel.swift
//  PersonalScheduler
//
//  Created by 써니쿠키 on 2023/02/07.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKUser

final class LoginViewModel {
    private var userInfo: UserInfo? = nil 
    private(set) var title: String = "Schedule"
    private(set) var introduce: String = "Login and save your Schedule"
    
    private(set) var kakaoLoginButtonViewModel = loginButtonViewModel(title: "Login with Kakao",
                                                                 logo: UIImage(named: "KakaoLogo"),
                                                                 backgroundColor: .kakao,
                                                                 textColor: .black)
    
    private(set) var facebookLoginButtonViewModel = loginButtonViewModel(title: "Login with Facebook",
                                                                    logo: UIImage(named: "FacebookLogo"),
                                                                    backgroundColor: .facebook,
                                                                    textColor: .white)
}

//MARK: - KakaoLogin
extension LoginViewModel {

    func kakaoLogin() {
        UserApi.isKakaoTalkLoginAvailable() ? loginWithApp() : loginWithAccount()
    }

    private func loginWithApp() {
        UserApi.shared.loginWithKakaoTalk {(user, error) in
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
            self.userInfo = UserInfo(id: "kakao\(id)")
        }
    }
}
