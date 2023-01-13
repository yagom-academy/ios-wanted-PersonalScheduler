//
//  LoginViewModel.swift
//  PersonalScheduler
//
//  Created by TORI on 2023/01/12.
//

import Foundation

final class LoginViewModel {
    
    private let useCase: SignInUseCase!
    
    init(useCase: SignInUseCase = SignInUseCase()) {
        self.useCase = useCase
    }
    
    func appleLoginIn() {
        useCase.appleSignIn()
    }
}
