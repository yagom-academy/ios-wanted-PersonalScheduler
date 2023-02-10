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
    
    func logout(completion: @escaping (Result<Void, Error>) -> Void)
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
    
    func logout(completion: @escaping (Result<Void, Error>) -> Void) {
        guard let _ = try? Auth.auth().signOut() else {
            completion(.failure(LoginError.unknown))
            return
        }
        
        completion(.success(()))
    }
}
