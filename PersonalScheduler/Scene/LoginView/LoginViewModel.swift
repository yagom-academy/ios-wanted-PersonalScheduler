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
            break
        }
    }
}
