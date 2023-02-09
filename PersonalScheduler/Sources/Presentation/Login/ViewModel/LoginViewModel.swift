//
//  LoginViewModel.swift
//  PersonalScheduler
//
//  Copyright (c) 2023 Minii All rights reserved.

import AuthenticationServices
import Combine
import FirebaseAuth
import FacebookLogin

class LoginViewModel: NSObject {
    private var loginRepository: LoginRepository?
    private var cancellable = Set<AnyCancellable>()
    private(set) var isSuccess: CurrentValueSubject<Bool, Never> = CurrentValueSubject(false)
    
    func login(with repository: LoginRepository) {
        self.loginRepository = repository
        
        self.loginRepository?.login { result in
            switch result {
            case .success:
                self.isSuccess.send(true)
            case .failure:
                self.isSuccess.send(false)
            }
        }
    }
}
