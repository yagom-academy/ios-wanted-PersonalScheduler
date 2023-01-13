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
import FirebaseAuth

protocol LoginViewModelInputInterface {
    func tappedKaKaoButton()
    func tappedLogoutButton()
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
                UserApi.shared.me() {(user, error) in
                    if let error = error {
                        print(error)
                    }

                    Auth.auth().createUser(withEmail: (user?.kakaoAccount?.email)!, password: "\(String(describing: user?.id))") { result, error in
                        if let error = error {
                            print("파이어베이스 사용자 생성 실패 \(error.localizedDescription)")
                        } else {
                            UserDefaults.standard.set(result?.user.uid, forKey: "uid")
                            print("파이어베이스 사용자 생성")
                            self.kakaoLoginPublisher.send()
                        }
                    }
                }
            }
        }
    }

    private func kakaoLoginWithAccount(completion: @escaping (OAuthToken) -> Void) {
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
            if let error = error {
                print(error)
            } else {
                completion(oauthToken!)
                self.kakaoLoginPublisher.send()
            }
        }
    }

    private func getUserInfo() {
        UserApi.shared.me() {(user, error) in
            if let error = error {
                print(error)
            } else {
                if let email = UserDefaults.standard.string(forKey: "email"),
                   let password = UserDefaults.standard.string(forKey: "password") {
                    Auth.auth().createUser(withEmail: email, password: password) { result, error in
                        if let error = error {
                            print("파이어베이스 사용자 생성 실패 \(error.localizedDescription)")
                        } else {
                            UserDefaults.standard.set(result?.user.uid, forKey: "uid")
                            UserDefaults.standard.set(user?.kakaoAccount?.email, forKey: "email")
                            UserDefaults.standard.set(user?.id, forKey: "password")
                            print("파이어베이스 사용자 생성")
                            self.kakaoLoginPublisher.send()
                        }
                    }
                } else {
                    Auth.auth().createUser(withEmail: (user?.kakaoAccount?.email)!, password: "\(String(describing: user?.id))") { result, error in
                        if let error = error {
                            print("파이어베이스 사용자 생성 실패 \(error.localizedDescription)")
                        } else {
                            UserDefaults.standard.set(result?.user.uid, forKey: "uid")
                            UserDefaults.standard.set(user?.kakaoAccount?.email, forKey: "email")
                            UserDefaults.standard.set(user?.id, forKey: "password")
                            print("파이어베이스 사용자 생성")
                            Auth.auth().signIn(withEmail: (user?.kakaoAccount?.email)!, password: "\(String(describing: user?.id))") { result, error in
                                guard error == nil else { return }
                                self.kakaoLoginPublisher.send()
                            }
                        }
                    }
                }
            }
        }
    }

    func autoLogin() {
        guard let email = UserDefaults.standard.string(forKey: "email"),
              let password = UserDefaults.standard.string(forKey: "password") else { return }

        UserApi.shared.me() {(user, error) in
            if let error = error {
                print(error)
            } else {
                self.kakaoLoginPublisher.send()
            }
        }
    }

    @MainActor
    private func kakaoLogin() {
        Task {
            if (UserApi.isKakaoTalkLoginAvailable()) {
                await kakaoLoginWithAPP()
            } else {
                kakaoLoginWithAccount { _ in
                    self.getUserInfo()
                }
            }
        }
    }

    private func handleKakaoLogout() {
        UserApi.shared.logout {(error) in
            if let error = error {
                print(error)
            } else {
                do {
                    try Auth.auth().signOut()
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

extension LoginViewModel: LoginViewModelInputInterface {
    @MainActor func tappedKaKaoButton() {
        guard !AuthApi.hasToken() else {
            kakaoLoginPublisher.send()
            return }
        kakaoLogin()
    }

    func tappedLogoutButton() {
        handleKakaoLogout()
    }
}
