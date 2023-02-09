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
    @Published private(set) var isSuccess: Bool = false
    
    func login(with repository: LoginRepository) {
        self.loginRepository = repository
        
        self.loginRepository?.login()
            .sink { self.isSuccess = $0 }
            .store(in: &cancellable)
    }
}
