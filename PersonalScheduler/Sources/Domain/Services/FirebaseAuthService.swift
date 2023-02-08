//
//  FirebaseService.swift
//  PersonalScheduler
//
//  Copyright (c) 2023 Minii All rights reserved.

import FirebaseAuth
import Combine

final class FirebaseAuthService: LoginService {
    @Published private(set) var authResult: Bool = false
    
    func login(with credential: AuthCredential) -> AnyPublisher<Bool, Never> {
        Auth.auth().signIn(with: credential) { result, error in
            guard error == nil else {
                self.authResult = false
                return
            }
            
            self.authResult = true
        }
        
        return AnyPublisher($authResult)
    }
}
