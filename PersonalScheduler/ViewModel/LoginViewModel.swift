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
    private var userInfo: Observable<UserInfo?> = Observable(nil)
    private(set) var title: String = "Scheduler"
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
            self.userInfo.value = UserInfo(id: "kakao\(id)")
        }
    }
}

//MARK: - Facebook Login
extension LoginViewModel {
    
    func loginWithFacebook(target viewController: UIViewController) {
        let manager = LoginManager()
        manager.logIn(permissions: ["public_profile"], from: viewController) { result, error in
            if let error = error {
                print("Process error: \(error)")
                return
            }
            guard let result = result else {
                print("No Result")
                return
            }
            if result.isCancelled {
                print("Login Cancelled")
                return
            }
            
            guard let id = result.token?.appID else {
                print("no Id")
                return
            }
            
            self.userInfo.value = UserInfo(id: "facebook"+id)

            let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
            Auth.auth().signIn(with: credential)
        }
    }
}
