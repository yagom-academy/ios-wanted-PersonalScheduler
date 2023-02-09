//
//  AppleLoginRepository.swift
//  PersonalScheduler
//
//  Copyright (c) 2023 Minii All rights reserved.

import AuthenticationServices
import Combine
import FirebaseAuth

final class AppleLoginRepository: LoginRepository {
    @Published private(set) var loginResult: Bool = false
    private let credential: ASAuthorizationAppleIDCredential
    let service: LoginService
    
    init(
        credential: ASAuthorizationAppleIDCredential,
        loginResult: Bool = false,
        service: LoginService = FirebaseAuthService()
    ) {
        self.loginResult = loginResult
        self.credential = credential
        self.service = service
    }
    
    func login() -> AnyPublisher<Bool, Never> {
        guard let tokenData = credential.identityToken,
              let token = String(data: tokenData, encoding: .utf8) else {
            return AnyPublisher($loginResult)
        }
        
        let firebaseCredential = OAuthProvider.credential(
            withProviderID: "apple.com",
            idToken: token,
            rawNonce: nil
        )
        
        return service.login(with: firebaseCredential)
    }
}
