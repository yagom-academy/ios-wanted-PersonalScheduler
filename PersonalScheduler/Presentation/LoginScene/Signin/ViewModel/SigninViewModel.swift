//
//  SigninViewModel.swift
//  PersonalScheduler
//
//  Created by 이원빈 on 2023/01/10.
//

struct SigninViewModelActions {
    let registerButtonTapped: (LoginInfo) -> Void
}

protocol SigninViewModelInput {
    func registerButtonTapped(_ loginInfo: LoginInfo)
}
protocol SigninViewModelOutput {}
protocol SigninViewModel: SigninViewModelInput, SigninViewModelOutput {}

final class DefaultSigninViewModel: SigninViewModel {
    private let actions: SigninViewModelActions?
    
    init(actions: SigninViewModelActions? = nil) {
        self.actions = actions
    }
    
    func registerButtonTapped(_ loginInfo: LoginInfo) {
        actions?.registerButtonTapped(loginInfo)
    }
}
