//
//  LoginViewModel.swift
//  PersonalScheduler
//
//  Created by Wonbi on 2023/02/08.
//

import Foundation
import FacebookLogin

protocol LoginViewModelDelegate: AnyObject {
    func loginViewModel(failedFacebookLogin error: Error)
    func loginViewModel(invalidToken error: Error?)
    func loginViewModel(failedFirestoreLogin error: Error?)
    func loginViewModel(successLogin uid: String)
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
            break
        case .tapFacebookLogin:
            tapFacebookLogin()
        }
    }
}

extension LoginViewModel {
    func tapFacebookLogin() {
        facebookLoginManager.logIn(permissions: ["email"], from: nil) { result, error in
            if let error = error {
                self.delegate?.loginViewModel(failedFacebookLogin: error)
                return
            }
            
            guard let token = AccessToken.current?.tokenString else {
                self.delegate?.loginViewModel(invalidToken: error)
                return
            }
            
            self.service.requestLogin(with: token) { [weak self] result in
                switch result {
                case .success(let uid):
                    self?.delegate?.loginViewModel(successLogin: uid)
                case .failure(let failure):
                    self?.delegate?.loginViewModel(failedFirestoreLogin: failure)
                }
            }
        }
    }
    
    func tapFacebookLogout() {
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
