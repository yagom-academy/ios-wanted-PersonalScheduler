//
//  FirebaseService.swift
//  PersonalScheduler
//
//  Copyright (c) 2023 Minii All rights reserved.

import FirebaseAuth
import Combine

protocol LoginService {
    var userId: String { get }
    
    func login(
        with credential: AuthCredential,
        completion: @escaping (Result<Void, LoginError>) -> Void
    )
    
    func logout(completion: @escaping (Result<Void, Error>) -> Void)
}

final class FirebaseAuthService: LoginService {
    @Published var userId: String = ""
    
    func login(
        with credential: AuthCredential,
        completion: @escaping (Result<Void, LoginError>) -> Void
    ) {
        Auth.auth().signIn(with: credential) { result, error in
            guard error == nil else {
                completion(.failure(.unReadCredential))
                return
            }
            guard let userId = Auth.auth().currentUser?.uid else {
                completion(.failure(.unknown))
                return
            }
            
            self.userId = userId
            
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
