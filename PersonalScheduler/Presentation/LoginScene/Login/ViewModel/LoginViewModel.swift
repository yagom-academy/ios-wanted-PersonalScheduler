//
//  LoginViewModel.swift
//  PersonalScheduler
//
//  Created by 이원빈 on 2023/01/09.
//

import Foundation

struct LoginViewModelActions {
    let loginButtonTapped: () -> Void
}

protocol LoginViewModelInput {
    func loginButtonTapped()
}

protocol LoginViewModelOutput {}

protocol LoginViewModel: LoginViewModelInput, LoginViewModelOutput {}

final class DefaultLoginViewModel: LoginViewModel {
    private let actions: LoginViewModelActions?
    
    init(actions: LoginViewModelActions? = nil) {
        self.actions = actions
    }
    
    func loginButtonTapped() {
        actions?.loginButtonTapped()
    }
}
