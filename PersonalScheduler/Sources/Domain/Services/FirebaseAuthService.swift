//
//  FirebaseService.swift
//  PersonalScheduler
//
//  Copyright (c) 2023 Minii All rights reserved.

import FirebaseAuth
import Combine

protocol LoginService {
    func login(
        with credential: AuthCredential,
        completion: @escaping (Result<Void, LoginError>) -> Void
    )
}

final class FirebaseAuthService: LoginService {
    func login(
        with credential: AuthCredential,
        completion: @escaping (Result<Void, LoginError>) -> Void
    ) {
        Auth.auth().signIn(with: credential) { result, error in
            guard error == nil else {
                completion(.failure(.unReadCredential))
                return
            }
            
            completion(.success(()))
        }
    }
}
