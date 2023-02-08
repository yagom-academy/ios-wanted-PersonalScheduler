//
//  LoginViewModel.swift
//  PersonalScheduler
//
//  Created by Wonbi on 2023/02/08.
//

import Foundation
import FacebookLogin


final class LoginViewModel {
    enum Action {
        case tapKakaoLogin
        case tapFacebookLogin
    }
    
    private let facebookLoginManager = LoginManager()
    private let service: LoginService
    
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
