//
//  FacebookLoginRepository.swift
//  PersonalScheduler
//
//  Copyright (c) 2023 Minii All rights reserved.

import Combine
import FacebookLogin
import FirebaseAuth

final class FacebookRepository: LoginRepository {
    @Published private(set) var loginResult: Bool = false
    private var cancellable = Set<AnyCancellable>()
    let service: LoginService
    
    init(service: LoginService = FirebaseAuthService()) {
        self.service = service
    }
    
    func login() -> AnyPublisher<Bool, Never> {
        observeLogin()
        return AnyPublisher($loginResult)
    }
    
    func observeLogin() {
        LoginManager().logIn(permissions: ["email"], from: nil) { result, error in
            guard error == nil,
                  let result = result,
                  result.isCancelled == false,
                  let token = result.token?.tokenString else {
                self.loginResult = false
                return
            }
            
            let credential = FacebookAuthProvider.credential(withAccessToken: token)
            
            self.service.login(with: credential)
                .sink { self.loginResult = $0 }
                .store(in: &self.cancellable)
        }
    }
}
