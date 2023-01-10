//
//  LoginViewModel.swift
//  PersonalScheduler
//
//  Created by 이원빈 on 2023/01/09.
//

import Foundation

struct LoginViewModelActions {
    let loginButtonTapped: (LoginInfo) -> Void
    let signinButtonTapped: () -> Void
    let kakaoLogoButtonTapped: () -> Void
    let facebookLogoButtonTapped: () -> Void
    let appleLogoButtonTapped: () -> Void
}

protocol LoginViewModelInput {
    func loginButtonTapped(_ loginInfo: LoginInfo)
    func signinButtonTapped()
    func kakaoLogoButtonTapped()
    func facebookLogoButtonTapped()
    func appleLogoButtonTapped()
}

protocol LoginViewModelOutput {}

protocol LoginViewModel: LoginViewModelInput, LoginViewModelOutput {}

final class DefaultLoginViewModel: LoginViewModel {
    private let actions: LoginViewModelActions?
    
    init(actions: LoginViewModelActions? = nil) {
        self.actions = actions
    }
    
    func loginButtonTapped(_ loginInfo: LoginInfo) {
        actions?.loginButtonTapped(loginInfo)
    }
    
    func signinButtonTapped() {
        actions?.signinButtonTapped()
    }
    
    func kakaoLogoButtonTapped() {
        actions?.kakaoLogoButtonTapped()
    }
    
    func facebookLogoButtonTapped() {
        actions?.facebookLogoButtonTapped()
    }
    
    func appleLogoButtonTapped() {
        actions?.appleLogoButtonTapped()
    }
}
