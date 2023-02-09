//
//  FacebookLoginRepository.swift
//  PersonalScheduler
//
//  Copyright (c) 2023 Minii All rights reserved.

import FacebookLogin
import FirebaseAuth

final class FacebookRepository: LoginRepository {
    let service: LoginService
    
    init(service: LoginService = FirebaseAuthService()) {
        self.service = service
    }
    
    func login(completion: @escaping (Result<Void, LoginError>) -> Void) {
        LoginManager().logIn(permissions: ["email"], from: nil) { result, error in
            guard error == nil,
                  let result = result,
                  result.isCancelled == false,
                  let token = result.token?.tokenString else {
                return
            }
            
            let credential = FacebookAuthProvider.credential(withAccessToken: token)
            
            self.service.login(with: credential, completion: completion)
        }
    }
}
