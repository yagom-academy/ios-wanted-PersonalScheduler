//
//  LoginViewModel.swift
//  PersonalScheduler
//
//  Created by Wonbi on 2023/02/08.
//

import Foundation

import FacebookLogin
import KakaoSDKUser

protocol LoginViewModelDelegate: AnyObject {
    func loginViewModel(successLogin uid: String)
    func loginViewModel(failedLogin error: Error)
    func loginViewModel(successLogout: Void)
    func loginViewModel(failedLogout error: Error)
}

final class LoginViewModel {
    enum Action {
        case tapKakaoLogin
        case tapFacebookLogin
    }
    
    private let facebookLoginManager = LoginManager()
    private let service: LoginService
    weak var delegate: LoginViewModelDelegate?
    
    init(service: LoginService) {
        self.service = service
    }
    
    func action(_ action: Action) {
        switch action {
        case .tapKakaoLogin:
            tapKakaoLogin()
        case .tapFacebookLogin:
            tapFacebookLogin()
        }
    }
}

// MARK: Kakao
extension LoginViewModel {
    private func loginWithKakaoTalk() {
        UserApi.shared.loginWithKakaoTalk { [weak self] (oauthToken, error) in
            if let error = error {
                self?.delegate?.loginViewModel(failedLogin: error)
                return
            }
            
            guard let idToken = oauthToken?.idToken else { return }
            
            self?.service.requestLogin(to: .kakao, with: idToken) { [weak self] result in
                switch result {
                case .success(let uid):
                    self?.delegate?.loginViewModel(successLogin: uid)
                case .failure(let failure):
                    self?.delegate?.loginViewModel(failedLogin: failure)
                }
            }
        }
    }
    
    private func loginWithKakaoAccount() {
        UserApi.shared.loginWithKakaoAccount { [weak self] (oauthToken, error) in
            if let error = error {
                self?.delegate?.loginViewModel(failedLogin: error)
                return
            }
            
            guard let idToken = oauthToken?.idToken else { return }
            
            self?.service.requestLogin(to: .kakao, with: idToken) { [weak self] result in
                switch result {
                case .success(let uid):
                    self?.delegate?.loginViewModel(successLogin: uid)
                case .failure(let failure):
                    self?.delegate?.loginViewModel(failedLogin: failure)
                }
            }
        }
    }
    
    private func tapKakaoLogin() {
        if UserApi.isKakaoTalkLoginAvailable() {
            loginWithKakaoTalk()
        } else {
            loginWithKakaoAccount()
        }
    }
}

// MARK: Facebook
extension LoginViewModel {
    private func tapFacebookLogin() {
        if let token = AccessToken.current, !token.isExpired {
            loginFireStore(with: token)
        } else {
            facebookLoginManager.logIn(permissions: ["email"], from: nil) { [weak self] result, error in
                if let error = error {
                    self?.delegate?.loginViewModel(failedLogin: error)
                    return
                }
                
                guard let result = result,
                      !result.isCancelled,
                      let token = result.token
                else {
                    return
                }
                
                self?.loginFireStore(with: token)
            }
        }
    }
    
    private func loginFireStore(with token: AccessToken) {
        service.requestLogin(to: .facebook, with: token.tokenString) { [weak self] result in
            switch result {
            case .success(let uid):
                self?.delegate?.loginViewModel(successLogin: uid)
            case .failure(let failure):
                self?.delegate?.loginViewModel(failedLogin: failure)
            }
        }
    }
    
    private func tapFacebookLogout() {
        facebookLoginManager.logOut()
        service.requestLogout { [weak self] result in
            switch result {
            case .success():
                self?.delegate?.loginViewModel(successLogout: ())
            case .failure(let failure):
                self?.delegate?.loginViewModel(failedLogout: failure)
            }
        }
    }
}
