//
//  SignInUseCase.swift
//  PersonalScheduler
//
//  Created by TORI on 2023/01/13.
//

import Foundation

final class SignInUseCase {
    
    let repository: SignInRepositoryProtocol!
    
    init(repository: SignInRepositoryProtocol = SignInRepository()) {
        self.repository = repository
    }
    
    func appleSignIn() {
        repository.appleIDAuthorization()
    }
}
