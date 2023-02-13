//
//  FacebookLoginRepository.swift
//  PersonalScheduler
//
//  Copyright (c) 2023 Minii All rights reserved.

import FacebookLogin
import FirebaseAuth

final class FacebookRepository: LoginRepository {
    let service: LoginService
    private let loginManager = LoginManager()
    
    init(service: LoginService = FirebaseAuthService()) {
        self.service = service
    }
    
    func login(completion: @escaping (Result<Void, LoginError>) -> Void) {
        if let token = AccessToken.current, token.isExpired == false {
            loginOfFirebase(with: token.tokenString, completion: completion)
            return
        }
        
        loginWithFacebookManager(completion: completion)
    }
}

private extension FacebookRepository {
    func loginWithFacebookManager(completion: @escaping (Result<Void, LoginError>) -> Void) {
        loginManager.logIn(permissions: ["email"], from: nil) { [weak self] result, error in
            guard let self = self else {
                completion(.failure(.unknown))
                return
            }
            
            guard error == nil,
                  let result = result else {
                completion(.failure(.loginServiceError))
                return
            }
            
            guard result.isCancelled == false else {
                completion(.failure(.cancelLogin))
                return
            }
            
            guard let token = result.token?.tokenString else {
                completion(.failure(.failDecodeToken))
                return
            }
            
            self.loginOfFirebase(with: token, completion: completion)
        }
    }
    
    func loginOfFirebase(with token: String, completion: @escaping (Result<Void, LoginError>) -> Void) {
        let credential = FacebookAuthProvider.credential(withAccessToken: token)
        
        service.login(with: credential, completion: completion)
    }
}
