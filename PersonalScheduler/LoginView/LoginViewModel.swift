//
//  LoginViewModel.swift
//  PersonalScheduler
//
//  Created by unchain on 2023/01/11.
//
import KakaoSDKAuth
import KakaoSDKUser
import Foundation
import Combine

protocol LoginViewModelInputInterface {
    func tappedKaKaoButton()
    func tappedKaKaoLogoutButton()
}

protocol LoginViewModelOutputInterface {
    var kakaoLoginPublisher: PassthroughSubject<Void, Never> { get }
}

protocol LoginViewModelInterface {
    var input: LoginViewModelInputInterface { get }
    var output: LoginViewModelOutputInterface { get }
}

final class LoginViewModel: LoginViewModelOutputInterface, LoginViewModelInterface  {
    var kakaoLoginPublisher = PassthroughSubject<Void, Never>()
    var input: LoginViewModelInputInterface { self }
    var output: LoginViewModelOutputInterface { self }

    var subScriptions = Set<AnyCancellable>()

    private func kakaoLoginWithAPP() async {
        UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
            if let error = error {
                print(error)
            }
            else {
                self.kakaoLoginPublisher.send()
                _ = oauthToken
            }
        }
    }

    private func kakaoLoginWithAccount() async {
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
            if let error = error {
                print(error)
            }
            else {
                //do something
                self.kakaoLoginPublisher.send()
                _ = oauthToken
            }
        }
    }

    private func kakaoLogin() {
        Task {
            if (UserApi.isKakaoTalkLoginAvailable()) {
                await kakaoLoginWithAPP()
            } else {
                await kakaoLoginWithAccount()
            }
        }
    }

    private func handleKakaoLogout() {
        UserApi.shared.logout {(error) in
            if let error = error {
                print(error)
            }
            else {
            }
        }
    }
}

extension LoginViewModel: LoginViewModelInputInterface {
    func tappedKaKaoButton() {
        guard !AuthApi.hasToken() else {
            kakaoLoginPublisher.send()
            return }
        kakaoLogin()
    }

    func tappedKaKaoLogoutButton() {
        handleKakaoLogout()
    }
}
