//
//  AppleLoginRepository.swift
//  PersonalScheduler
//
//  Copyright (c) 2023 Minii All rights reserved.

import AuthenticationServices
import Combine
import FirebaseAuth

final class AppleLoginRepository: LoginRepository {
    private let credential: ASAuthorizationAppleIDCredential
    let service: LoginService
    
    init(
        credential: ASAuthorizationAppleIDCredential,
        service: LoginService = FirebaseAuthService()
    ) {
        self.credential = credential
        self.service = service
    }
    
    func login(completion: @escaping (Result<Void, LoginError>) -> Void) {
        guard let tokenData = credential.identityToken,
              let token = String(data: tokenData, encoding: .utf8) else {
            completion(.failure(.invalidToken))
            return
        }
        
        let firebaseCredential = OAuthProvider.credential(
            withProviderID: "apple.com",
            idToken: token,
            rawNonce: nil
        )
        
        service.login(with: firebaseCredential, completion: completion)
    }
}
