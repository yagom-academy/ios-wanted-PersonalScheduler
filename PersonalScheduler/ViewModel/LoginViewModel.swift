//
//  LoginViewModel.swift
//  PersonalScheduler
//
//  Created by 써니쿠키 on 2023/02/07.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKUser
import FacebookLogin
import Firebase

final class LoginViewModel {
    
    private(set) var userId: Observable<String?> = Observable(nil)
    private(set) var error: Observable<Error?> = Observable(nil)
    private(set) var title: String = "Personal \n Scheduler"
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

    func loginWithKakao() {
        UserApi.isKakaoTalkLoginAvailable() ? loginWithApp() : loginWithAccount()
    }

    private func loginWithApp() {
        UserApi.shared.loginWithKakaoTalk { [weak self] (user, error) in
            if let error = error {
                self?.error.value = error
            } else {
                self?.fetchUserInfo()
            }
        }
    }

    private func loginWithAccount() {
        UserApi.shared.loginWithKakaoAccount { [weak self] (_, error) in
            if let error = error {
                self?.error.value = error
            } else {
                self?.fetchUserInfo()
            }
        }
    }

    private func fetchUserInfo() {
        UserApi.shared.me() { [weak self] (user, error) in
            if let error = error {
                self?.error.value = error
            }

            guard let id = user?.id else { return }

            self?.userId.value = "kakao\(id)"
        }
    }
}

//MARK: - Facebook Login
extension LoginViewModel {
    
    func loginWithFacebook(target viewController: UIViewController) {
        let manager = LoginManager()
        manager.logIn(permissions: ["public_profile"], from: viewController) { [weak self] result, error in
            if let error = error {
                print("Process error: \(error)")
                self?.error.value = error
                return
            }

            guard let result = result else {
                print("No Result")
                self?.error.value = error
                return
            }

            if result.isCancelled {
                print("Login Cancelled")
                self?.error.value = error
                return
            }
            
            guard let id = result.token?.appID else {
                print("no Id")
                self?.error.value = error
                return
            }

            self?.userId.value = "facebook\(id)"
        }
    }
}
